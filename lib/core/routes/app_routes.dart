import 'package:flutter/material.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/travel/travel_packages_screen.dart';
import '../../core/layout/main_layout.dart';
import '../../features/consultation/consultation_screen.dart';
import '../../features/consultation/appointment_booking.dart';
import '../../features/consultation/doctor_list.dart';
import '../../features/consultation/doctor_profile.dart';
import '../../features/consultation/appointment_confirmation.dart';
import '../../features/consultation/appointment_history.dart';
import '../../features/consultation/video_call.dart';
import '../../features/vet_team/vet_team_screen.dart';
import '../../features/products/product_detail.dart';
import '../../features/products/cart_screen.dart';
import '../../features/products/checkout_screen.dart';
import '../../features/animals/my_animals_screen.dart';
import '../../features/animals/animal_profile.dart';
import '../../features/animals/add_animal.dart';
import '../../features/profile/settings_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/home/more_menu_screen.dart';
import '../../features/home/notifications_screen.dart';
import '../../features/consultation/health_records_screen.dart';
import '../../features/consultation/health_record_detail.dart';
import '../../features/consultation/emergency_help_screen.dart';
import '../../features/health_records/pet_passport_screen.dart';
import '../../features/home/pet_care_tips_screen.dart';
import '../../features/home/faqs_screen.dart';
import '../../features/home/about_us_screen.dart';
import '../../features/home/founders_stories_screen.dart';
import '../../features/home/accreditations_screen.dart';
import '../../features/home/contact_us_screen.dart';
import '../../features/home/articles_videos_screen.dart';
import '../../features/home/feedback_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String gopuAi = '/gopu-ai';
  static const String consultation = '/consultation';
  static const String appointmentBooking = '/appointment-booking';
  static const String doctorList = '/doctor-list';
  static const String doctorProfile = '/doctor-profile';
  static const String appointmentConfirmation = '/appointment-confirmation';
  static const String appointmentHistory = '/appointment-history';
  static const String videoCall = '/video-call';
  static const String vetTeam = '/vet-team';
  static const String products = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String myAnimals = '/my-animals';
  static const String animalProfile = '/animal-profile';
  static const String addAnimal = '/add-animal';
  static const String healthRecords = '/health-records';
  static const String vaccination = '/vaccination';
  static const String emergency = '/emergency';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String moreMenu = '/more-menu';
  static const String healthRecordDetail = '/health-record-detail';
  static const String petPassport = '/pet-passport';
  static const String emergencyHelp = '/emergency-help';
  static const String petCareTips = '/pet-care-tips';
  static const String articlesVideos = '/articles-videos';
  static const String faqs = '/faqs';
  static const String aboutUs = '/about-us';
  static const String foundersStories = '/founders-stories';
  static const String accreditations = '/accreditations';
  static const String contactUs = '/contact-us';
  static const String feedback = '/feedback';
  static const String travelPackages = '/travel-packages';

  // Aliases for missing getters
  static const String vetProfile = doctorProfile;
  static const String addPet = addAnimal;
  static const String petProfile = animalProfile;
  static const String productList = products;

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        login: (context) => const LoginScreen(),
        signup: (context) => const SignupScreen(),
        home: (context) => const MainLayout(initialIndex: 3),
        gopuAi: (context) => const MainLayout(initialIndex: 0),
        consultation: (context) => const MainLayout(initialIndex: 1),
        products: (context) => const MainLayout(initialIndex: 2),
        appointmentBooking: (context) => const AppointmentBookingScreen(),
        doctorList: (context) => const DoctorListScreen(),
        doctorProfile: (context) => const DoctorProfileScreen(),
        appointmentConfirmation: (context) => const AppointmentConfirmationScreen(),
        appointmentHistory: (context) => const AppointmentHistoryScreen(),
        videoCall: (context) => const VideoCallScreen(),
        vetTeam: (context) => const VetTeamScreen(),
        productDetail: (context) => const ProductDetailScreen(),
        cart: (context) => const CartScreen(),
        checkout: (context) => const CheckoutScreen(),
        myAnimals: (context) => const MyAnimalsScreen(),
        animalProfile: (context) => const AnimalProfileScreen(),
        addAnimal: (context) => const AddAnimalScreen(),
        healthRecords: (context) => const HealthRecordsScreen(),
        moreMenu: (context) => const MoreMenuScreen(),
        healthRecordDetail: (context) => const HealthRecordDetailScreen(),
        petPassport: (context) => const PetPassportScreen(),
        emergencyHelp: (context) => const EmergencyHelpScreen(),
        editProfile: (context) => const EditProfileScreen(),
        settings: (context) => const SettingsScreen(),
        petCareTips: (context) => const PetCareTipsScreen(),
        articlesVideos: (context) => const ArticlesVideosScreen(),
        faqs: (context) => const FaqsScreen(),
        aboutUs: (context) => const AboutUsScreen(),
        foundersStories: (context) => const FoundersStoriesScreen(),
        accreditations: (context) => const AccreditationsScreen(),
        contactUs: (context) => const ContactUsScreen(),
        feedback: (context) => const FeedbackScreen(),
        notifications: (context) => const NotificationsScreen(),
        travelPackages: (context) => const TravelPackagesScreen(),
      };
}
