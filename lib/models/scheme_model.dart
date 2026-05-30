class SchemeModel {
  final String name;
  final String category;
  final String image;
  final String description;
  final String benefits;
  final String eligibility;
  final String documents;
  final String applyUrl;

  SchemeModel({
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.benefits,
    required this.eligibility,
    required this.documents,
    required this.applyUrl,
  });
}

List<SchemeModel> governmentSchemes = [
  // ================= SUBSIDIES =================

  SchemeModel(
    name: "PM-Kisan Samman Nidhi",
    category: "Subsidies",
    image: "assets/schemes/pm_kisan.webp",
    description:
        "The PM-KISAN (Pradhan Mantri Kisan Samman Nidhi) scheme is a central government initiative launched in 2019 that provides eligible landholding farmer families with an income support of ₹6,000 per year. The money is transferred directly into farmers' bank accounts in three equal installments of ₹2,000 every four months using Direct Benefit Transfer (DBT)",
    benefits:
        "Direct Income Support: Provides predictable, assured cash flow to assist with seeds, fertilizers, and labor costs.Direct Benefit Transfer (DBT): Eliminates middlemen by sending funds straight to Aadhaar-seeded bank accounts, ensuring transparency and reducing leakages.No Cap on Land: Though originally designed for Small and Marginal Farmers (SMFs), the scheme now extends to all eligible landholding farmer families, regardless of the size of their landholdings.",
    eligibility:
        "Landholding Requirement: You (or your family, which includes husband, wife, and minor children) must collectively own cultivable land.Active Status: You must be actively engaged in farming and agricultural activities.",
    documents: "Aadhaar, Bank Passbook, Land Records,proof of citizenship",
    applyUrl: "https://pmkisan.gov.in",
  ),

  SchemeModel(
    name: "National Horticulture Mission",
    category: "Subsidies",
    image: "assets/schemes/nhm.png",
    description:
        "The National Horticulture Mission (NHM) is a government initiative aimed at promoting holistic growth of the horticulture sector. It supports farmers in cultivating fruits, vegetables, spices, flowers, medicinal plants, and plantation crops through financial assistance, infrastructure development, and modern farming practices.",
    benefits:
        "Subsidy for establishing new orchards and nurseries. Financial assistance for protected cultivation such as polyhouses and shade-net houses. Support for drip irrigation, water harvesting structures, and post-harvest management. Assistance for cold storage facilities, pack houses, and marketing infrastructure. Improved productivity, quality, and income for horticulture farmers.",
    eligibility:
        "Eligible EntitiesEligible promoters include:Individual farmers and entrepreneursNGOs, proprietary firms, and registered partnerships or companiesCooperatives, Farmer Producer Organizations (FPOs), and Self-Help Groups (SHGs)Agricultural universities and R&D organizations",
    documents:
        "Proof of Identity (Aadhaar Card, Voter ID)Land records (RoR, Patta, or registered lease deed)Caste Certificate (if claiming SC/ST subsidy benefits)Bank passbook or canceled cheque for direct benefit transferPassport size photographs",
    applyUrl: "https://nhm.gov.in",
  ),

  SchemeModel(
    name: "PM Krishi Sinchai Yojana",
    category: "Subsidies",
    image: "assets/schemes/pmksy.jpg",
    description:
        "Pradhan Mantri Krishi Sinchai Yojana (PMKSY) is a flagship government scheme launched to improve water use efficiency and expand irrigation coverage across agricultural lands. The scheme focuses on the motto 'Per Drop More Crop' by promoting micro-irrigation systems, water conservation, rainwater harvesting, and sustainable irrigation practices.",
    benefits:
        "Subsidy on drip and sprinkler irrigation systems. Financial assistance for water harvesting structures and farm ponds. Improved water use efficiency and crop productivity. Reduced irrigation costs and better drought resilience. Enhanced agricultural income through efficient water management.",
    eligibility:
        "Individual farmers, Farmer Producer Organizations (FPOs), Self-Help Groups (SHGs), cooperatives, agricultural institutions, and state-approved beneficiaries owning or cultivating agricultural land are eligible under the scheme",
    documents:
        "Aadhaar Card, Land ownership records or lease agreement, Bank passbook or cancelled cheque, Passport-size photographs, Mobile number, Irrigation project proposal or application form, Caste certificate (if applicable).",
    applyUrl: "https://pmksy.gov.in",
  ),

  SchemeModel(
    name: "Paramparagat Krishi Vikas Yojana",
    category: "Subsidies",
    image: "assets/schemes/pmksy.jpg",
    description:
        "Paramparagat Krishi Vikas Yojana (PKVY) is a government scheme launched to promote organic farming across India. The scheme encourages farmers to adopt eco-friendly agricultural practices, reduce chemical fertilizer usage, and produce certified organic products through cluster-based farming and Participatory Guarantee System (PGS) certification.",
    benefits:
        "Financial assistance for organic farming activities. Support for organic certification through Participatory Guarantee System (PGS). Reduced dependency on chemical fertilizers and pesticides. Improved soil health and environmental sustainability. Better market opportunities and premium prices for organic produce",
    eligibility:
        "Individual farmers, Farmer Producer Organizations (FPOs), farmer groups, cooperatives, and clusters of farmers willing to adopt organic farming practices are eligible. Farmers are encouraged to form groups of at least 20 hectares under cluster-based organic cultivation",
    documents:
        "Aadhaar Card, Land ownership records or lease agreement, Bank passbook or cancelled cheque, Passport-size photographs, Farmer registration details, Organic farming cluster membership proof, Mobile number for communication.",
    applyUrl: "https://pgsindia-ncof.gov.in",
  ),

  SchemeModel(
    name: "RKVY",
    category: "Subsidies",
    image: "assets/schemes/nhm.png",
    description:
        "Rashtriya Krishi Vikas Yojana (RKVY) is a centrally sponsored scheme aimed at strengthening agricultural infrastructure, increasing farmer income, and promoting innovation in the agriculture sector. The scheme supports state-specific agricultural projects, farm modernization, value addition, post-harvest management, and agri-entrepreneurship initiatives.",
    benefits:
        "Financial assistance for agricultural infrastructure development. Support for farm mechanization and modernization. Funding for storage, processing, and value-addition projects. Promotion of agri-startups and innovation. Increased agricultural productivity, profitability, and market access for farmers.",
    eligibility:
        "Individual farmers, Farmer Producer Organizations (FPOs), cooperatives, agri-entrepreneurs, startups, Self-Help Groups (SHGs), and agricultural institutions undertaking approved agricultural development projects are eligible under the scheme.",
    documents:
        "Aadhaar Card, Land ownership records or lease agreement, Bank passbook or cancelled cheque, Passport-size photographs, Project proposal or business plan, Farmer registration details, Mobile number, Any additional documents required by the implementing agency",
    applyUrl: "https://rkvy.nic.in",
  ),

  // ================= INSURANCE =================

  SchemeModel(
    name: "PMFBY",
    category: "Insurance",
    image: "assets/schemes/pmfby.webp",
    description:
        "Pradhan Mantri Fasal Bima Yojana (PMFBY) is a flagship crop insurance scheme launched by the Government of India to provide financial protection to farmers against crop losses caused by natural calamities, pests, diseases, droughts, floods, cyclones, and other unforeseen events. The scheme aims to stabilize farmers' income and encourage them to adopt modern agricultural practices without the fear of financial loss..",
    benefits:
        "Comprehensive insurance coverage against crop failure due to natural disasters, pests, and diseases. Low premium rates for farmers with the remaining premium subsidized by the government. Quick claim settlement through technology-based crop assessment. Financial security and income stabilization for farmers. Encourages investment in modern farming techniques and improved agricultural productivity.",
    eligibility:
        "All farmers cultivating notified crops in notified areas are eligible under the scheme. Both loanee farmers (those who have taken crop loans) and non-loanee farmers can enroll. Farmers must register within the specified enrollment period and provide accurate crop-sowing details..",
    documents:
        "Aadhaar Card, Bank Passbook, Land Ownership Records or Lease Agreement, Crop Sowing Certificate, Passport-size Photographs, Mobile Number, Loan Account Details (for loanee farmers), and any additional documents required by the implementing agency.",
    applyUrl: "https://pmfby.gov.in",
  ),

  SchemeModel(
    name: "WBCIS",
    category: "Insurance",
    image: "assets/schemes/wbcis.jpg",
    description:
        "The Weather Based Crop Insurance Scheme (WBCIS) is a government-supported crop insurance program that provides financial protection to farmers against adverse weather conditions such as drought, excess rainfall, unseasonal rain, frost, heat waves, cold waves, and other weather-related risks. The scheme uses weather data from authorized weather stations to determine compensation, ensuring faster and more transparent claim settlements.",
    benefits:
        "Protection against financial losses caused by adverse weather conditions. Quick and transparent claim settlement based on weather data. Reduced dependence on manual crop loss assessments. Improved income stability for farmers during unfavorable weather seasons. Encourages farmers to adopt modern agricultural practices without fear of weather-related losses.",
    eligibility:
        "All farmers cultivating notified crops in notified areas are eligible under the scheme. Both loanee and non-loanee farmers can enroll. Farmers must register within the prescribed enrollment period and declare the crops being cultivated for the insurance season.",
    documents: "Aadhaar, Land Details",
    applyUrl: "https://pmfby.gov.in",
  ),

  SchemeModel(
    name: "Coconut Palm Insurance",
    category: "Insurance",
    image: "assets/schemes/coconut_insurance.jpg",
    description:
        "The Coconut Palm Insurance Scheme (CPIS) is a specialized insurance program designed to provide financial protection to coconut growers against the loss of coconut palms due to natural calamities, pests, diseases, lightning, cyclones, floods, storms, and other unforeseen events. The scheme helps farmers recover losses and maintain sustainable coconut cultivation.",
    benefits:
        "Insurance coverage for coconut palms against natural and biological hazards. Financial compensation for damaged or destroyed coconut trees. Reduced economic burden on coconut farmers after disasters. Encourages long-term investment in coconut cultivation. Supports livelihood security for coconut-growing families.",
    eligibility:
        "Individual coconut farmers, farmer groups, cooperatives, and coconut growers owning healthy coconut palms within the eligible age group specified under the scheme are eligible to enroll. The palms must be registered and insured through authorized agencies.",
    documents:
        "Aadhaar Card, Land Ownership Records or Lease Agreement, Bank Passbook or Cancelled Cheque, Passport-size Photographs, Coconut Farm Registration Details, Mobile Number, Farmer Identification Proof, and any additional documents required by the Coconut Development Board or implementing agency.",
    applyUrl: "https://coconutboard.gov.in",
  ),

  SchemeModel(
    name: "Livestock Insurance",
    category: "Insurance",
    image: "assets/schemes/livestock_insurance.jpg",
    description:
        "The Livestock Insurance Scheme is a government initiative designed to protect farmers and livestock owners from financial losses arising due to the death of insured animals. The scheme covers cattle, buffaloes, and other eligible livestock against risks such as diseases, accidents, natural calamities, and unforeseen events. It aims to encourage animal husbandry and provide economic security to rural households dependent on livestock.",
    benefits:
        "Financial compensation in case of death of insured livestock. Reduced economic burden on farmers and dairy owners. Encourages investment in high-quality breeds and animal husbandry. Protection against losses caused by diseases, accidents, floods, cyclones, and natural disasters. Supports sustainable livestock farming and rural livelihoods.",
    eligibility:
        "Individual farmers, dairy farmers, livestock owners, Self-Help Groups (SHGs), cooperatives, and rural households owning eligible livestock such as cattle and buffaloes can enroll under the scheme. Animals must be healthy and properly identified at the time of insurance enrollment.",
    documents:
        "Aadhaar Card, Animal Ownership Proof, Veterinary Health Certificate, Bank Passbook or Cancelled Cheque, Passport-size Photographs, Animal Identification Tag Details, Mobile Number, and any additional documents required by the implementing agency or insurance provider.",
    applyUrl: "https://dahd.nic.in",
  ),

  SchemeModel(
    name: "UPIS",
    category: "Insurance",
    image: "assets/schemes/upis.jpg",
    description:
        "The Unified Package Insurance Scheme (UPIS) is a comprehensive insurance initiative designed to provide multiple layers of protection to farmers under a single package. In addition to crop insurance, the scheme offers coverage for personal accidents, life insurance, agricultural assets, student safety, and other risks that may affect farming households. The objective is to provide holistic financial security and reduce the vulnerability of farmers to various uncertainties..",
    benefits:
        "Comprehensive protection through a single insurance package. Crop insurance coverage against natural calamities and crop losses. Personal accident and life insurance benefits for farmers and their families. Coverage for agricultural assets and equipment in selected regions. Reduced financial burden during emergencies and improved social security for farming households.",
    eligibility:
        "Farmers enrolled under notified crop insurance programs and eligible beneficiaries approved by participating banks, insurance companies, or government agencies can avail benefits under the scheme. Both loanee and non-loanee farmers may be eligible depending on state implementation guidelines.",
    documents:
        "Aadhaar Card, Bank Passbook, Land Ownership Records or Lease Agreement, Passport-size Photographs, Mobile Number, Farmer Registration Details, Crop Sowing Information, Insurance Enrollment Form, and any additional documents required by the implementing agency.",
    applyUrl: "https://pmfby.gov.in",
  ),

  // ================= LOANS =================

  SchemeModel(
    name: "Kisan Credit Card",
    category: "Loans",
    image: "assets/schemes/kcc.jpg",
    description:
        "The Kisan Credit Card (KCC) Scheme is a government-backed agricultural credit program that provides farmers with timely and affordable access to short-term loans for crop cultivation, post-harvest expenses, farm maintenance, and allied agricultural activities. The scheme helps farmers meet their financial requirements without depending on informal lenders and supports sustainable agricultural growth.",
    benefits:
        "Easy access to short-term agricultural credit at low interest rates. Flexible repayment options based on crop harvesting cycles. Interest subsidy benefits for timely repayment. Financial support for crop cultivation, seeds, fertilizers, pesticides, irrigation, and farm equipment. Coverage extended to animal husbandry, fisheries, and allied agricultural activities. Simplified loan disbursement process through banks and financial institutions.",
    eligibility:
        "Individual farmers, tenant farmers, sharecroppers, oral lessees, Self-Help Groups (SHGs), Joint Liability Groups (JLGs), and farmers engaged in crop production, animal husbandry, fisheries, and allied agricultural activities are eligible to apply for a Kisan Credit Card.",
    documents:
        "Aadhaar Card, PAN Card (if applicable), Land Ownership Records or Lease Agreement, Bank Passbook, Passport-size Photographs, Mobile Number, Farmer Registration Details, Income Proof (if required), and any additional documents requested by the lending institution.",
    applyUrl: "https://www.myscheme.gov.in",
  ),

  SchemeModel(
    name: "Agriculture Infrastructure Fund",
    category: "Loans",
    image: "assets/schemes/aif.jpg",
    description:
        "The Agriculture Infrastructure Fund (AIF) is a government financing facility launched to support the development of post-harvest management infrastructure and community farming assets across India. The scheme provides medium to long-term debt financing for projects such as warehouses, cold storage units, grading and sorting centers, processing facilities, and supply chain infrastructure, helping farmers reduce post-harvest losses and improve income.",
    benefits:
        "Access to affordable loans for agricultural infrastructure projects. Interest subvention of up to 3% per annum on eligible loans. Credit guarantee support for approved projects. Financial assistance for warehouses, cold storage facilities, processing units, packaging centers, and logistics infrastructure. Reduced post-harvest losses and improved market access for farmers. Encourages value addition and higher profitability in agriculture.",
    eligibility:
        "Farmers, Farmer Producer Organizations (FPOs), Primary Agricultural Credit Societies (PACS), cooperatives, Self-Help Groups (SHGs), agri-entrepreneurs, startups, agricultural institutions, and other eligible entities involved in agricultural infrastructure development can apply under the scheme.",
    documents:
        "Aadhaar Card, PAN Card, Bank Passbook or Cancelled Cheque, Project Report or Business Plan, Land Ownership or Lease Documents, Registration Certificate (for FPOs, cooperatives, or companies), Passport-size Photographs, Mobile Number, and any additional documents required by the lending institution.",
    applyUrl: "https://agriinfra.dac.gov.in",
  ),

  SchemeModel(
    name: "NABARD Assistance",
    category: "Loans",
    image: "assets/schemes/nabard.jpg",
    description:
        "NABARD (National Bank for Agriculture and Rural Development) provides financial assistance and credit support to farmers, rural entrepreneurs, Farmer Producer Organizations (FPOs), cooperatives, and agricultural institutions. The scheme aims to promote sustainable agriculture, rural development, irrigation projects, farm mechanization, dairy farming, fisheries, and agri-based enterprises by facilitating access to affordable credit and development programs.",
    benefits:
        "Access to low-interest agricultural loans and development finance. Financial assistance for irrigation, farm mechanization, dairy, fisheries, and rural enterprises. Support for Farmer Producer Organizations (FPOs) and rural infrastructure projects. Encourages modernization of agriculture and adoption of new technologies. Enhances rural employment opportunities and farmer income",
    eligibility:
        "Individual farmers, Farmer Producer Organizations (FPOs), Self-Help Groups (SHGs), cooperatives, rural entrepreneurs, agri-startups, dairy farmers, fisheries operators, and other eligible rural development beneficiaries can avail financial assistance under NABARD-supported programs through participating banks and institutions.",
    documents:
        "Aadhaar Card, PAN Card (if applicable), Bank Passbook or Cancelled Cheque, Land Ownership Records or Lease Agreement, Identity Proof, Address Proof, Passport-size Photographs, Project Report or Business Plan (for enterprise loans), Mobile Number, and any additional documents required by the lending institution.",
    applyUrl: "https://nabard.org",
  ),

  SchemeModel(
    name: "Dairy Loan Scheme",
    category: "Loans",
    image: "assets/schemes/dairy_loan.jpg",
    description:
        "he Dairy Loan Scheme is a financial assistance program designed to support dairy farmers in establishing, expanding, and modernizing dairy farming operations. The scheme provides access to affordable credit for purchasing dairy animals, constructing cattle sheds, buying milking equipment, setting up feed storage facilities, and improving overall dairy productivity. It aims to strengthen rural livelihoods and promote sustainable dairy entrepreneurship",
    benefits:
        "Financial assistance for purchasing cows, buffaloes, and other dairy animals. Loans for constructing cattle sheds and dairy infrastructure. Support for purchasing milking machines, cooling units, and feed management equipment. Increased milk production and farm profitability. Encourages self-employment and income generation in rural areas. Flexible repayment options through participating banks and financial institutions.",
    eligibility:
        "Individual dairy farmers, Self-Help Groups (SHGs), Farmer Producer Organizations (FPOs), dairy cooperatives, rural entrepreneurs, and individuals interested in starting or expanding dairy farming activities are eligible to apply under the scheme, subject to the lending institution's guidelines.",
    documents:
        "Aadhaar Card, PAN Card (if applicable), Bank Passbook or Cancelled Cheque, Passport-size Photographs, Dairy Farm Project Report or Business Plan, Land Ownership Records or Lease Agreement, Mobile Number, Existing Livestock Details (if applicable), and any additional documents required by the lending institution",
    applyUrl: "https://dahd.nic.in",
  ),

  SchemeModel(
    name: "Stand-Up India",
    category: "Loans",
    image: "assets/schemes/standup_india.jpg",
    description:
        "Stand-Up India is a flagship government initiative aimed at promoting entrepreneurship among women and members of Scheduled Castes (SC) and Scheduled Tribes (ST). The scheme facilitates bank loans for setting up new businesses in manufacturing, services, trading, and agri-allied sectors. It encourages job creation, economic empowerment, and inclusive growth by supporting first-time entrepreneurs.",
    benefits:
        "Bank loans ranging from ₹10 lakh to ₹1 crore for new business ventures. Financial support for manufacturing, services, trading, and agricultural enterprises. Handholding assistance for business planning, registration, training, and project implementation. Encourages self-employment, innovation, and job creation. Promotes entrepreneurship among women and underrepresented communities.",
    eligibility:
        "Women entrepreneurs and individuals belonging to Scheduled Castes (SC) or Scheduled Tribes (ST) above 18 years of age are eligible. The applicant must be setting up a new (greenfield) enterprise in manufacturing, services, trading, or agri-allied sectors. In case of non-individual enterprises, at least 51% ownership and controlling stake must be held by eligible beneficiaries.",
    documents:
        "Aadhaar Card, PAN Card, Passport-size Photographs, Bank Account Details, Business Proposal or Project Report, Address Proof, Educational Qualification Certificates (if applicable), Caste Certificate (for SC/ST applicants), Mobile Number, and any additional documents required by the lending institution.",
    applyUrl: "https://standupmitra.in",
  ),

  // ================= EQUIPMENT =================

  SchemeModel(
    name: "SMAM",
    category: "Equipment",
    image: "assets/schemes/smam..jpg",
    description:
        "The Sub-Mission on Agricultural Mechanization (SMAM) is a government initiative aimed at increasing the adoption of modern agricultural machinery and equipment among farmers. The scheme promotes farm mechanization to improve agricultural productivity, reduce labor dependency, and enhance operational efficiency. It provides financial assistance for the purchase of tractors, harvesters, seed drills, power tillers, and other advanced farming equipment.",
    benefits:
        "Subsidy on the purchase of agricultural machinery and equipment. Improved farm productivity and operational efficiency. Reduced dependence on manual labor and lower cultivation costs. Access to modern farming technologies for small and marginal farmers. Support for Custom Hiring Centers (CHCs) to provide machinery on rent. Increased crop yields and higher farmer income.",
    eligibility:
        "Individual farmers, Self-Help Groups (SHGs), Farmer Producer Organizations (FPOs), cooperatives, agricultural entrepreneurs, and eligible farming institutions can apply under the scheme. Priority is often given to small and marginal farmers, women farmers, and farmers belonging to SC/ST categories.",
    documents:
        "Aadhaar Card, Land Ownership Records or Lease Agreement, Bank Passbook or Cancelled Cheque, Passport-size Photographs, Mobile Number, Farmer Registration Details, Caste Certificate (if applicable), Quotation for Agricultural Equipment, and any additional documents required by the implementing agency.",
    applyUrl: "https://agrimachinery.nic.in",
  ),

  SchemeModel(
    name: "Machinery Bank",
    category: "Equipment",
    image: "assets/schemes/machinery_bank.jpg",
    description:
        "The Machinery Bank Scheme is designed to provide farmers with affordable access to modern agricultural machinery through a shared equipment model. Under this scheme, farmer groups, cooperatives, Farmer Producer Organizations (FPOs), and agricultural institutions can establish machinery banks where farmers can rent tractors, harvesters, seed drills, rotavators, and other equipment instead of purchasing them. This helps reduce cultivation costs and promotes farm mechanization among small and marginal farmers.",
    benefits:
        "Affordable access to modern farm machinery without the need for full ownership. Reduced cultivation and operational costs for farmers. Increased farm productivity and efficiency through mechanized farming. Support for small and marginal farmers who cannot afford expensive equipment. Encourages resource sharing and community-based agricultural development. Improves timely farm operations and crop yields.",
    eligibility:
        "Farmer Producer Organizations (FPOs), Self-Help Groups (SHGs), cooperatives, farmer groups, agricultural societies, rural entrepreneurs, and eligible farming institutions can establish or benefit from Machinery Banks under the scheme. Individual farmers may access equipment through registered machinery banks.",
    documents:
        "Aadhaar Card, Farmer Registration Certificate, Bank Passbook or Cancelled Cheque, Land Ownership Records or Lease Agreement, Passport-size Photographs, Group Registration Certificate (for FPOs, SHGs, or cooperatives), Mobile Number, Machinery Purchase Proposal, and any additional documents required by the implementing authority.",
    applyUrl: "https://agrimachinery.nic.in",
  ),

  SchemeModel(
    name: "Custom Hiring Centre",
    category: "Equipment",
    image: "assets/schemes/chc.jpg",
    description:
        "The Custom Hiring Centre (CHC) Scheme is a government initiative that enables farmers to access modern agricultural machinery and equipment on a rental basis. The scheme is particularly beneficial for small and marginal farmers who cannot afford to purchase expensive machinery. CHCs provide equipment such as tractors, harvesters, rotavators, seed drills, power tillers, and spraying machines, helping farmers adopt mechanized farming practices at affordable rates.",
    benefits:
        "Affordable access to modern agricultural machinery without requiring ownership. Reduced cultivation and operational costs for farmers. Timely completion of land preparation, sowing, irrigation, spraying, and harvesting activities. Increased farm productivity and efficiency through mechanized farming. Special support for small and marginal farmers who cannot afford expensive equipment. Encourages adoption of modern agricultural technologies and improves crop yields.",
    eligibility:
        "Farmer Producer Organizations (FPOs), cooperatives, Self-Help Groups (SHGs), registered farmer groups, rural entrepreneurs, agricultural societies, Panchayati Raj Institutions, and eligible agricultural organizations can establish Custom Hiring Centres. Individual farmers can avail machinery rental services through registered CHCs. Priority is often given to small and marginal farmers, women farmers, and SC/ST beneficiaries.",
    documents:
        "Aadhaar Card, Farmer Registration Certificate, Land Ownership Records or Lease Agreement, Bank Passbook or Cancelled Cheque, Passport-size Photographs, Mobile Number, Group Registration Certificate (for FPOs, SHGs, Cooperatives, or Societies), Project Proposal for CHC establishment, Machinery Procurement Details, and any additional documents required by the implementing authority",
    applyUrl: "https://agrimachinery.nic.in",
  ),

  SchemeModel(
    name: "NFSM Equipment Support",
    category: "Equipment",
    image: "assets/schemes/nfsm_equipment.jpg",
    description:
        "The National Food Security Mission (NFSM) Equipment Support Scheme is a government initiative aimed at increasing the production and productivity of key food crops such as rice, wheat, pulses, coarse cereals, and nutri-cereals. Under this scheme, farmers receive financial assistance to purchase modern agricultural machinery and equipment that improve farming efficiency, reduce labor dependency, and enhance crop yields. The scheme supports the adoption of advanced technologies for sustainable agricultural development and national food security.",
    benefits:
        "Subsidy on agricultural machinery and farm equipment. Improved crop productivity and farm efficiency. Reduced labor costs through mechanized farming operations. Support for modern equipment such as seed drills, planters, threshers, harvesters, weeders, and crop residue management machinery. Enhanced food grain production and better resource utilization. Increased farmer income through higher yields and reduced operational expenses.",
    eligibility:
        "Individual farmers, Farmer Producer Organizations (FPOs), Self-Help Groups (SHGs), cooperatives, agricultural institutions, and farmer groups engaged in cultivating NFSM-notified crops such as rice, wheat, pulses, and coarse cereals are eligible for assistance under the scheme. Priority may be given to small and marginal farmers, women farmers, and SC/ST beneficiaries.",
    documents:
        "Aadhaar Card, Land Ownership Records or Lease Agreement, Bank Passbook or Cancelled Cheque, Passport-size Photographs, Mobile Number, Farmer Registration Certificate, Quotation for Agricultural Equipment, Caste Certificate (if applicable), and any additional documents required by the implementing agency",
    applyUrl: "https://nfsm.gov.in",
  ),

  SchemeModel(
    name: "Drone Subsidy",
    category: "Equipment",
    image: "assets/schemes/drone_subsidy.jpg",
    description:
        "The Drone Subsidy Scheme is a government initiative aimed at promoting precision agriculture through the adoption of drone technology. The scheme provides financial assistance for purchasing and operating agricultural drones used for crop monitoring, pesticide spraying, nutrient application, field mapping, crop health assessment, and precision farming. It helps farmers improve productivity, reduce input costs, and adopt modern technology-driven farming practices.",
    benefits:
        "Subsidy of up to 40%–75% on approved agricultural drones depending on the beneficiary category. Faster and more efficient spraying of pesticides, fertilizers, and micronutrients. Improved crop monitoring and disease detection through aerial surveys. Reduced labor costs and increased operational efficiency. Better resource management and precision farming capabilities. Encourages adoption of advanced agricultural technologies and sustainable farming practices.",
    eligibility:
        "Individual farmers, Farmer Producer Organizations (FPOs), Self-Help Groups (SHGs), cooperatives, Custom Hiring Centres (CHCs), agricultural startups, Krishi Vigyan Kendras (KVKs), agricultural universities, and government-recognized institutions are eligible for assistance under the scheme. Eligibility and subsidy rates may vary based on government guidelines.",
    documents:
        "Aadhaar Card, Farmer Registration Certificate, Land Ownership Records or Lease Agreement, Bank Passbook or Cancelled Cheque, Passport-size Photographs, Mobile Number, Drone Purchase Quotation or Invoice, Organization Registration Certificate (for FPOs, CHCs, or institutions), GST Registration (if applicable), and any additional documents required by the implementing authority.",
    applyUrl: "https://agrimachinery.nic.in",
  ),

  // ================= TRAINING =================

  SchemeModel(
    name: "ATMA",
    category: "Training",
    image: "assets/schemes/atma.jpg",
    description:
        "The Agricultural Technology Management Agency (ATMA) is a government-supported extension and training program designed to transfer modern agricultural technologies and best farming practices directly to farmers. The scheme focuses on improving productivity, profitability, and sustainability through farmer training, demonstrations, exposure visits, skill development programs, and knowledge-sharing activities. ATMA acts as a bridge between agricultural research institutions and farmers, ensuring the adoption of innovative farming techniques.",
    benefits:
        "Free or subsidized agricultural training programs for farmers. Exposure visits to successful farms and agricultural institutions. Demonstrations of modern farming technologies and equipment. Capacity building in crop management, horticulture, livestock, fisheries, and allied sectors. Improved agricultural productivity, profitability, and sustainable farming practices. Better access to expert guidance and agricultural innovations.",
    eligibility:
        "Individual farmers, women farmers, youth involved in agriculture, Farmer Producer Organizations (FPOs), Self-Help Groups (SHGs), farmer clubs, and agricultural entrepreneurs are eligible to participate in ATMA training and extension activities conducted by district-level agricultural departments.",
    documents:
        "Aadhaar Card, Farmer Registration Certificate, Land Ownership Records or Lease Agreement (if applicable), Passport-size Photographs, Mobile Number, Identity Proof, Bank Account Details (for eligible benefits), and any additional documents required by the district ATMA office or implementing authority.",
    applyUrl: "https://atmaindia.co.in",
  ),

  SchemeModel(
    name: "STRY",
    category: "Training",
    image: "assets/schemes/stry.jpg",
    description:
        "The Skill Training for Rural Youth (STRY) program is a government-supported initiative aimed at empowering rural youth with modern agricultural and agribusiness skills. The scheme focuses on developing technical knowledge, entrepreneurship capabilities, and practical farming expertise through structured training programs, workshops, demonstrations, and field exposure visits. STRY helps young farmers adopt innovative agricultural technologies and create sustainable livelihood opportunities in the agriculture sector.",
    benefits:
        "Free or subsidized agricultural skill development programs. Training in modern farming techniques, agribusiness management, and farm mechanization. Exposure to advanced agricultural technologies and successful farming models. Entrepreneurship development and self-employment opportunities. Improved employability in agriculture and allied sectors. Enhanced income generation and sustainable rural livelihoods.",
    eligibility:
        "Rural youth interested in agriculture, young farmers, aspiring agri-entrepreneurs, members of Self-Help Groups (SHGs), Farmer Producer Organizations (FPOs), and individuals seeking skill development in agriculture and allied sectors are eligible to participate in STRY training programs.",
    documents:
        "Aadhaar Card, Identity Proof, Passport-size Photographs, Mobile Number, Educational Qualification Certificates (if applicable), Farmer Registration Certificate (if applicable), Address Proof, and any additional documents required by the training provider or implementing authority.",
    applyUrl: "https://agricoop.nic.in",
  ),

  SchemeModel(
    name: "ACABC",
    category: "Training",
    image: "assets/schemes/acabc.jpg",
    description:
        "The Agri-Clinics and Agri-Business Centres (ACABC) Scheme is a government initiative aimed at creating self-employment opportunities for agricultural graduates and diploma holders. The scheme provides specialized training, entrepreneurship support, and financial assistance to establish agri-clinics and agri-business centres that offer professional agricultural services, input supply, consultancy, and technology support to farmers.",
    benefits:
        "Entrepreneurship training and skill development. Subsidy support for establishing agri-business ventures. Access to bank loans and financial assistance. Opportunities for self-employment in agriculture and allied sectors. Professional consultancy and extension services for farmers. Promotion of modern farming technologies and agribusiness innovation.",
    eligibility:
        "Agriculture graduates, horticulture graduates, veterinary graduates, fisheries graduates, forestry graduates, agricultural diploma holders, and other eligible candidates from allied agricultural disciplines can apply under the scheme.",
    documents:
        "Aadhaar Card, Educational Qualification Certificates, Passport-size Photographs, PAN Card, Bank Account Details, Business Plan or Project Report, Mobile Number, Address Proof, and any additional documents required by NABARD or the implementing agency.",
    applyUrl: "https://acabcmis.gov.in",
  ),

  SchemeModel(
    name: "KVK Training",
    category: "Training",
    image: "assets/schemes/kvk.jpg",
    description:
        "Krishi Vigyan Kendra (KVK) Training is an agricultural extension and skill development program conducted by ICAR's Krishi Vigyan Kendras across India. The program provides practical, field-based training to farmers, rural youth, women, and agricultural entrepreneurs. KVKs demonstrate modern farming technologies, sustainable agricultural practices, crop management techniques, livestock management, horticulture, fisheries, and agri-business opportunities to improve farm productivity and income.",
    benefits:
        "Free or subsidized hands-on agricultural training programs. Demonstrations of modern farming technologies and best practices. Expert guidance from agricultural scientists and specialists. Training in crop production, horticulture, livestock, fisheries, beekeeping, and allied sectors. Exposure to innovative agricultural equipment and techniques. Improved farm productivity, profitability, and sustainable farming practices.",
    eligibility:
        "Farmers, women farmers, rural youth, agricultural entrepreneurs, Self-Help Groups (SHGs), Farmer Producer Organizations (FPOs), students, and individuals interested in agriculture and allied activities are eligible to participate in KVK training programs.",
    documents:
        "Aadhaar Card, Farmer Registration Certificate (if applicable), Passport-size Photographs, Mobile Number, Identity Proof, Address Proof, Educational Qualification Certificates (if required), and any additional documents specified by the respective Krishi Vigyan Kendra.",
    applyUrl: "https://icar.org.in",
  ),

  SchemeModel(
    name: "Beekeeping Training",
    category: "Training",
    image: "assets/schemes/beekeeping.jpg",
    description:
        "The Beekeeping Training Program is a government-supported initiative under the National Beekeeping and Honey Mission (NBHM) aimed at promoting scientific beekeeping practices and honey production. The program provides practical training on bee colony management, honey harvesting, bee health, value-added products, and beekeeping entrepreneurship. It helps farmers diversify their income sources while also improving crop pollination and agricultural productivity.",
    benefits:
        "Free or subsidized training in modern beekeeping techniques. Increased income through honey, beeswax, royal jelly, and other bee products. Improved crop pollination leading to higher agricultural yields. Support for establishing beekeeping enterprises and self-employment opportunities. Access to technical guidance, equipment support, and government assistance programs. Encourages sustainable agriculture and biodiversity conservation.",
    eligibility:
        "Farmers, rural youth, women entrepreneurs, Self-Help Groups (SHGs), Farmer Producer Organizations (FPOs), agricultural graduates, and individuals interested in beekeeping and honey production are eligible to participate in the training program.",
    documents:
        "Aadhaar Card, Identity Proof, Passport-size Photographs, Mobile Number, Address Proof, Bank Account Details, Farmer Registration Certificate (if applicable), and any additional documents required by the National Beekeeping and Honey Mission or the implementing training institution.",
    applyUrl: "https://nbhm.gov.in",
  ),
];
