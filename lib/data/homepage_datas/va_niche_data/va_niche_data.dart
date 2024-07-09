class VANiche {
  final String name;
  final List<Map<String, String>> tasks;

  VANiche({required this.name, required this.tasks});
}

// Define the list of VA niches
final List<VANiche> vaNiches = [
  VANiche(
    name: 'HR Administrative',
    tasks: [
      {'Managing documents': 'Organizing and maintaining business documents for easy retrieval.'},
      {'Calling clients': 'Communicating with clients to schedule appointments and follow-ups.'},
      {'Answering inquiries': 'Responding to customer and client inquiries via phone, email, and chat.'},
      {'Processing documents': 'Handling the preparation, filing, and processing of various business documents.'},
      {'Recruiting and onboarding': 'Managing recruitment processes and onboarding new employees.'},
      {'Payroll and benefits': 'Assisting with payroll management and benefits administration.'},
    ],
  ),
  VANiche(
    name: 'Finance Accounting',
    tasks: [
      {'Managing financial records': 'Organizing and maintaining financial records and documents.'},
      {'Processing invoices': 'Handling the creation, sending, and tracking of invoices.'},
      {'Tracking expenses': 'Monitoring and recording business expenses to ensure accurate bookkeeping.'},
      {'Budgeting assistance': 'Helping to create and manage budgets for business operations.'},
      {'Financial reporting': 'Preparing financial reports and statements for review.'},
      {'Tax preparation': 'Assisting with the preparation and filing of business taxes.'},
    ],
  ),
  VANiche(
    name: 'Digital Marketing',
    tasks: [
      {'Content creation': 'Developing engaging content for digital platforms.'},
      {'Scheduling posts': 'Planning and scheduling posts to maintain a consistent online presence.'},
      {'Account setup and optimization': 'Creating and optimizing digital profiles.'},
      {'Engaging with followers': 'Interacting with followers by responding to comments and messages.'},
      {'Analyzing metrics': 'Monitoring and analyzing performance metrics.'},
      {'Running ads': 'Creating and managing paid advertising campaigns.'},
    ],
  ),
  VANiche(
    name: 'Tech Development',
    tasks: [
      {'Website creation': 'Designing and developing websites from scratch.'},
      {'Mobile app development': 'Creating mobile applications for various platforms.'},
      {'UI/UX design': 'Designing user interfaces and improving user experiences.'},
      {'Website maintenance': 'Performing regular updates and backups for websites.'},
      {'Bug fixing': 'Identifying and fixing bugs in websites and apps.'},
      {'API integration': 'Integrating third-party APIs into websites and apps.'},
    ],
  ),
  VANiche(
    name: 'Sales Generation',
    tasks: [
      {'Identifying leads': 'Researching and identifying potential clients and leads.'},
      {'Cold calling': 'Making cold calls to prospective clients to generate interest.'},
      {'Email outreach': 'Sending out targeted email campaigns to prospects.'},
      {'Managing sales pipelines': 'Tracking and managing the sales pipeline to ensure follow-ups.'},
      {'Qualifying leads': 'Assessing and qualifying leads to determine their potential.'},
      {'Setting appointments': 'Scheduling sales appointments and meetings with qualified leads.'},
    ],
  ),
  VANiche(
    name: 'Customer Relations',
    tasks: [
      {'Handling inquiries': 'Responding to customer inquiries via email, chat, and phone.'},
      {'Resolving issues': 'Providing solutions to customer problems and complaints.'},
      {'Order processing': 'Handling the processing and tracking of customer orders.'},
      {'Follow-up communication': 'Conducting follow-up communications with customers.'},
      {'Feedback collection': 'Collecting and analyzing customer feedback.'},
      {'Support documentation': 'Creating and updating customer support documentation.'},
    ],
  ),
  // Add VA Project Manager as a specialized VA
  VANiche(
    name: 'VA Project Manager',
    tasks: [
      {'Managing projects': 'Overseeing and managing various projects and tasks.'},
      {'Assigning tasks': 'Delegating tasks to specialized VAs.'},
      {'Monitoring progress': 'Tracking the progress of ongoing projects and tasks.'},
      {'Communicating with clients': 'Liaising with clients to understand their needs and provide updates.'},
      {'Reporting': 'Preparing and delivering progress reports.'},
      {'Quality assurance': 'Ensuring the quality of work delivered by the team.'},
    ],
  ),
];
