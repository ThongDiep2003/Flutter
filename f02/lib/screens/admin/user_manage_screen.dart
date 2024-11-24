import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class UserManageScreen extends StatefulWidget {
  @override
  _UserManageScreenState createState() => _UserManageScreenState();
}

class _UserManageScreenState extends State<UserManageScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();

  DateTime? _filterDate;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _users = data.entries.map((e) {
            final user = Map<String, dynamic>.from(e.value);
            user['id'] = e.key;
            return user;
          }).toList();
          _filteredUsers = _users;
        });
      }
    });
  }

  void _searchUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = _users;
      } else {
        _filteredUsers = _users
            .where((user) =>
                (user['email'] as String).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _filterUsersByDate(DateTime? date) {
    if (date == null) return;

    setState(() {
      _filteredUsers = _users.where((user) {
        final userTimestamp = user['timestamp'];
        if (userTimestamp != null) {
          final userDate = DateTime.fromMillisecondsSinceEpoch(userTimestamp);
          return DateFormat('yyyy-MM-dd').format(userDate) ==
              DateFormat('yyyy-MM-dd').format(date);
        }
        return false;
      }).toList();
    });
  }

  void _deleteUser(String userId) {
    _dbRef.child(userId).remove();
    setState(() {
      _filteredUsers.removeWhere((user) => user['id'] == userId);
      _users.removeWhere((user) => user['id'] == userId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'User Management',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today_outlined, color: Colors.black),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              _filterDate = selectedDate;
              _filterUsersByDate(selectedDate);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _searchUsers,
                decoration: InputDecoration(
                  hintText: 'Search by email',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // User List
            Expanded(
              child: _filteredUsers.isEmpty
                  ? Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _filteredUsers.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade200,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            title: Text(
                              user['email'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Created: ${user['timestamp'] != null ? DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(user['timestamp'])) : 'Unknown'}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _deleteUser(user['id']),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
