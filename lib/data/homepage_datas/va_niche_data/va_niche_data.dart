// va_niches_data.dart

class VANiche {
  final String name;
  final List<Map<String, String>> tasks;

  VANiche({required this.name, required this.tasks});
}

// Define the list of VA niches
final List<VANiche> vaNiches = [
  VANiche(
    name: 'General Virtual Assistant',
    tasks: [
      {'Email management and filtering': 'Organizing, sorting, and prioritizing emails in your inbox to ensure important messages are addressed promptly and spam is filtered out.'},
      {'Calendar management and scheduling': 'Managing your calendar by scheduling meetings, appointments, and events, and sending reminders to ensure you stay on track.'},
      {'Travel arrangements and bookings': 'Planning and booking travel itineraries, including flights, accommodations, transportation, and activities.'},
      {'Data entry and management': 'Inputting and organizing data into spreadsheets or databases, ensuring accuracy and easy access.'},
      {'Online research': 'Conducting research on various topics, gathering relevant information, and presenting findings in a structured format.'},
      {'Customer service support': 'Assisting with customer inquiries, complaints, and issues via email, phone, or chat, ensuring customer satisfaction.'},
      {'Creating and maintaining databases': 'Building and updating databases to keep information organized and up-to-date.'},
    ],
  ),
  VANiche(
    name: 'Social Media Management',
    tasks: [
      {'Content creation and scheduling': 'Developing engaging content (text, images, videos) for social media platforms and scheduling posts to maintain a consistent online presence.'},
      {'Social media account setup and optimization': 'Creating and optimizing social media profiles to enhance visibility and engagement.'},
      {'Engaging with followers and responding to comments': 'Interacting with your audience by responding to comments, messages, and engaging in conversations.'},
      {'Analyzing social media metrics and performance': 'Monitoring and analyzing social media analytics to track the performance of posts and campaigns, and making data-driven decisions to improve results.'},
      {'Running social media ads': 'Creating and managing paid advertising campaigns on social media platforms to increase reach and engagement.'},
      {'Influencer outreach and collaboration': 'Identifying and reaching out to influencers for partnerships and collaborations to expand your brand’s reach.'},
      {'Community management': 'Building and nurturing online communities by engaging with members, moderating discussions, and fostering a positive environment.'},
    ],
  ),
  VANiche(
    name: 'Computer Technical VA',
    tasks: [
      {'IT support and troubleshooting': 'Providing technical assistance and resolving issues related to hardware, software, and networks.'},
      {'Software installation and updates': 'Installing new software and keeping existing software up-to-date to ensure smooth operation.'},
      {'Website maintenance and updates': 'Performing regular updates, backups, and troubleshooting on websites to ensure they function properly and securely.'},
      {'Setting up and managing cloud services': 'Configuring and managing cloud storage and services to ensure data is accessible and secure.'},
      {'Data backup and recovery': 'Implementing data backup solutions and recovering lost data in case of hardware failure or other issues.'},
      {'Network setup and maintenance': 'Setting up and maintaining local area networks (LANs) and ensuring reliable internet connectivity.'},
      {'Cybersecurity and virus protection': 'Implementing security measures to protect against cyber threats and ensuring systems are free from viruses and malware.'},
    ],
  ),
  VANiche(
    name: 'Graphical Creation VA',
    tasks: [
      {'Creating logos and branding materials': 'Designing logos and other branding elements like business cards, letterheads, and packaging.'},
      {'Designing social media graphics and posts': 'Creating visually appealing graphics for social media posts, banners, and ads.'},
      {'Creating marketing materials like flyers, brochures, and posters': 'Designing print and digital marketing materials to promote products or services.'},
      {'Designing presentations and infographics': 'Creating professional presentations and infographics to effectively communicate information.'},
      {'Photo editing and retouching': 'Enhancing and retouching photos to improve their quality and appeal.'},
      {'Video editing and production': 'Editing and producing videos for various purposes, such as marketing, training, or social media.'},
      {'Creating website and app mockups': 'Designing mockups for websites and mobile apps to provide a visual representation of the final product.'},
    ],
  ),
  VANiche(
    name: 'Administrative VA',
    tasks: [
      {'Managing administrative tasks like filing and documentation': 'Organizing and maintaining files and documents to ensure easy retrieval and compliance with record-keeping standards.'},
      {'Handling phone calls and correspondence': 'Answering and making phone calls, and managing incoming and outgoing correspondence.'},
      {'Preparing reports and presentations': 'Compiling data and creating reports and presentations to support decision-making and communication.'},
      {'Booking appointments and managing schedules': 'Scheduling and coordinating appointments, meetings, and events.'},
      {'Managing office supplies and inventory': 'Keeping track of office supplies and placing orders to ensure necessary items are always available.'},
      {'Organizing meetings and taking minutes': 'Coordinating meetings, preparing agendas, and recording minutes to document discussions and decisions.'},
      {'Handling billing and invoicing': 'Preparing and sending invoices, tracking payments, and managing billing processes.'},
    ],
  ),
  VANiche(
    name: 'Marketing VA',
    tasks: [
      {'Conducting market research and competitor analysis': 'Gathering information about market trends, customer preferences, and competitors to inform marketing strategies.'},
      {'Developing and implementing marketing strategies': 'Creating and executing marketing plans to achieve business objectives.'},
      {'Creating and managing email marketing campaigns': 'Designing email newsletters, segmenting email lists, and sending campaigns to engage with customers.'},
      {'Managing online advertising campaigns': 'Planning, creating, and optimizing online ads to drive traffic and conversions.'},
      {'Writing and editing marketing content': 'Producing high-quality written content for blogs, websites, social media, and marketing materials.'},
      {'Analyzing marketing data and preparing reports': 'Tracking and analyzing marketing performance metrics and creating reports to measure the effectiveness of campaigns.'},
      {'SEO optimization and keyword research': 'Improving website visibility on search engines through keyword research, content optimization, and technical SEO practices.'},
    ],
  ),
];
