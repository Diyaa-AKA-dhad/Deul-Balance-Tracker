import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../providers/balance_provider.dart';

class PersonSettings extends StatefulWidget {
  final Person person;
  final bool isGirl;

  const PersonSettings({super.key, required this.person, required this.isGirl});

  @override
  State<PersonSettings> createState() => _PersonSettingsState();
}

class _PersonSettingsState extends State<PersonSettings> {
  late TextEditingController _nameController;
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.name);
    _refreshSuggestions();
  }

  void _refreshSuggestions() {
    // Delay to allow provider to load if not ready, though usually it is.
    // Better to just get it from provider.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BalanceProvider>(context, listen: false);
      setState(() {
        _suggestions = provider.getSuggestions(widget.isGirl);
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings for ${widget.person.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.person.color,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nickname',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                provider.updateName(widget.person, value);
              },
            ),
            const SizedBox(height: 10),
            const Text('Suggestions:'),
            Wrap(
              spacing: 8,
              children: _suggestions.map((suggestion) {
                return ActionChip(
                  label: Text(suggestion),
                  onPressed: () {
                    _nameController.text = suggestion;
                    provider.updateName(widget.person, suggestion);
                  },
                );
              }).toList(),
            ),
            TextButton.icon(
              onPressed: _refreshSuggestions,
              icon: const Icon(Icons.refresh),
              label: const Text('New Suggestions'),
            ),
            const SizedBox(height: 20),
            const Text('Theme Color:'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.availableColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    provider.updateColor(widget.person, color);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: widget.person.color == color
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
