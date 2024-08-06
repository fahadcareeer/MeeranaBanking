import 'package:flutter/material.dart';
import 'person.dart';
import 'result_screen.dart';
import '../custom_dropdown.dart';
import '../custom_app_bar.dart';

final Map<String, String> fieldLabels = {
  'age': 'Age',
  'job': 'Job',
  'maritalStatus': 'Marital Status',
  'education': 'Education',
  'balance': 'Balance',
  'personalLoan': 'Personal Loan',
  'housingLoan': 'Housing Loan',
  'campaign': 'Campaign',
  'daysSincePreviousContact': 'Days since previous contact',
  'previousContacts': 'Previous contacts',
  'previousCampaignOutcome': 'Outcome of previous campaign',
};

class UserInputForm extends StatefulWidget {
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _campaignController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _previousContactsController =
      TextEditingController();
  String? _selectedJob;
  String? _selectedMaritalStatus;
  String? _selectedEducation;
  String _selectedHousingLoan = '';
  String _selectedPersonalLoan = '';
  String? _selectedPreviousCampaignOutcome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backButton: true,
        c: context,
        title: 'Deposit Prediction',
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildTextField('age', _ageController, TextInputType.number,
                    'Please enter age', 'Enter age'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['job']!,
                  items: [
                    'Admin',
                    'Blue-Collar',
                    'Entrepreneur',
                    'Housemaid',
                    'Management',
                    'Retired',
                    'Self-Employed',
                    'Services',
                    'Student',
                    'Technician',
                    'Un-Employed'
                  ],
                  value: _selectedJob,
                  onChanged: (value) {
                    setState(() {
                      _selectedJob = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['maritalStatus']!,
                  items: ['single', 'married', 'divorced'],
                  value: _selectedMaritalStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedMaritalStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['education']!,
                  items: ['primary', 'secondary', 'tertiary', 'unknown'],
                  value: _selectedEducation,
                  onChanged: (value) {
                    setState(() {
                      _selectedEducation = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                    'balance',
                    _balanceController,
                    TextInputType.number,
                    'Please enter balance',
                    'Enter balance'),
                const SizedBox(height: 20),
                _buildSectionHeader('personalLoan'),
                _buildRadioGroup('personalLoan'),
                const SizedBox(height: 20),
                _buildSectionHeader('housingLoan'),
                _buildRadioGroup('housingLoan'),
                const SizedBox(height: 20),
                _buildTextField(
                    'campaign',
                    _campaignController,
                    TextInputType.number,
                    'Please enter a campaign number',
                    'Enter Campaign number'),
                const SizedBox(height: 20),
                _buildTextField(
                    'daysSincePreviousContact',
                    _daysController,
                    TextInputType.number,
                    'Please enter number of days',
                    'Enter Number of Days'),
                const SizedBox(height: 20),
                _buildTextField(
                    'previousContacts',
                    _previousContactsController,
                    TextInputType.number,
                    'Please enter number of contacts',
                    'Enter Number of Contacts'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['previousCampaignOutcome']!,
                  items: ['Success', 'Failure', 'Others', 'Unknown'],
                  value: _selectedPreviousCampaignOutcome,
                  onChanged: (value) {
                    setState(() {
                      _selectedPreviousCampaignOutcome = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String fieldName, TextEditingController controller,
      TextInputType inputType, String validationMessage, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldLabels[fieldName]!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800],
          ),
          keyboardType: inputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMessage;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String fieldName) {
    return Text(
      fieldLabels[fieldName]!,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildRadioGroup(String fieldName) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Yes'),
            value: 'yes',
            groupValue: fieldName == 'housingLoan'
                ? _selectedHousingLoan
                : _selectedPersonalLoan,
            onChanged: (value) {
              setState(() {
                if (fieldName == 'housingLoan') {
                  _selectedHousingLoan = value!;
                } else if (fieldName == 'personalLoan') {
                  _selectedPersonalLoan = value!;
                }
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('No'),
            value: 'no',
            groupValue: fieldName == 'housingLoan'
                ? _selectedHousingLoan
                : _selectedPersonalLoan,
            onChanged: (value) {
              setState(() {
                if (fieldName == 'housingLoan') {
                  _selectedHousingLoan = value!;
                } else if (fieldName == 'personalLoan') {
                  _selectedPersonalLoan = value!;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Person userInput = Person(
        age: int.parse(_ageController.text),
        job: _selectedJob ?? '',
        marital: _selectedMaritalStatus ?? '',
        education: _selectedEducation ?? '',
        balance: int.parse(_balanceController.text),
        personalLoan: _selectedPersonalLoan == 'yes',
        housingLoan: _selectedHousingLoan == 'yes',
        result: false, // Placeholder for result calculation
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(userInput: userInput, dummyData: []),
        ),
      );
    }
  }
}
