import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  const MaintenanceRequestScreen({super.key});

  @override
  State<MaintenanceRequestScreen> createState() => _MaintenanceRequestScreenState();
}

class _MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  // Controllers
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _transferNumberController = TextEditingController();
  final _requesterNameController = TextEditingController();
  final _dateController = TextEditingController();
  
  // Form fields state
  String? _selectedRequestType;
  
  // Dropdown options
  final List<String> _requestTypes = [
    'صيانة كهربائية',
    'صيانة سباكة',
    'صيانة تكييف',
    'أخرى'
  ];
  
  @override
  void initState() {
    super.initState();
    _dateController.text = _formatDate(DateTime.now());
    // Set a default name or get it from user profile
    _requesterNameController.text = 'مستخدم النظام'; // You can replace this with actual user name
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _transferNumberController.dispose();
    _requesterNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FCFD),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF00638B), // Dark Blue
                  Color(0xFF00A3B0), // Teal
                ],
              ),
            ),
          ),
          title: Text(
            'طلب صيانة',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF00A3B0), // Teal
                  Color(0xFF15B3B2), // Lighter Teal
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 32),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FCFD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Requester Name (Read-only)
                    TextFormField(
                      controller: _requesterNameController,
                      readOnly: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      decoration: InputDecoration(
                        labelText: 'اسم مقدم الطلب',
                        labelStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Request Type Dropdown
                    DropdownButtonFormField<String>(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'نوع الطلب',
                        labelStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        prefixIcon: const Icon(Icons.category_outlined, color: Colors.grey),
                      ),
                      items: _requestTypes
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(
                                  type,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRequestType = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء اختيار نوع الطلب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Transfer Number
                    TextFormField(
                      controller: _transferNumberController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'رقم التحويلة',
                        hintText: 'أدخل رقم التحويلة',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم التحويلة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date Field (Read-only, auto-filled with today's date)
                    TextFormField(
                      controller: _dateController,
                      style: const TextStyle(fontSize: 16),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'تاريخ الطلب',
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Service Description
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'وصف المشكلة',
                        hintText: 'الرجاء وصف المشكلة بشكل مفصل',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 60.0),
                          child: Icon(Icons.description_outlined, color: Colors.grey),
                        ),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال وصف الخدمة';
                        }
                        if (value.length < 10) {
                          return 'الوصف يجب أن يكون 10 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Implement form submission
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00638B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'إرسال الطلب',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
