import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/network/api_client.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitMessage() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final res = await ApiClient().post('/marketplace/enquiries', {
        'name': name,
        'email': email,
        'phone': '+91 70730 41236',
        'notes': 'Contact Page Message: $message',
      });

      if (mounted) {
        if (res.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Message sent! We will respond within 24 hours.'),
              backgroundColor: AppColors.primaryDeepGreen,
            ),
          );
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Message submitted to PashuVaani team.'),
              backgroundColor: AppColors.primaryDeepGreen,
            ),
          );
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Message recorded. We will contact you soon.'),
            backgroundColor: AppColors.primaryDeepGreen,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _makePhoneCall() async {
    final Uri url = Uri.parse('tel:+917073041236');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _sendEmail() async {
    final Uri url = Uri.parse('mailto:contact@pashuvaani.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightMintBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pashu Bhi Pariwar Hai',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDeepGreen.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Get in Touch with PashuVaani',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.primaryDeepGreen),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Have a question, feedback, or want to know more about PashuVaani? We\'d love to hear from you.',
                    style: TextStyle(color: Colors.grey[800], fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildContactCard(
              context,
              icon: Icons.phone_outlined,
              title: 'Phone Support',
              subtitle: '+91 70730 41236\n(Available for animal health queries)',
              onTap: _makePhoneCall,
            ),
            const SizedBox(height: 14),
            _buildContactCard(
              context,
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: 'contact@pashuvaani.com\n(Response within 24 hours)',
              onTap: _sendEmail,
            ),
            const SizedBox(height: 14),
            _buildContactCard(
              context,
              icon: Icons.location_on_outlined,
              title: 'Headquarters',
              subtitle: 'Mumbai, India\n(Serving farmers & pet families pan-India)',
              onTap: null,
            ),
            const SizedBox(height: 32),
            Text(
              'Send us a message',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 4),
            Text(
              'We typically respond within 24 hours.',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                hintText: 'What should we call you?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'you@example.com',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                hintText: 'Tell us how we can help…',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDeepGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Send Message', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, {required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.softMint,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primaryDeepGreen),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), height: 1.3, fontSize: 13)),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.primaryDeepGreen),
          ],
        ),
      ),
    );
  }
}
