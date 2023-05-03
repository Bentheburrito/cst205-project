CREATE DATABASE quiz_webapp;
use quiz_webapp;

CREATE TABLE subjects (
	id int auto_increment primary key,
	name varchar(120) NOT NULL,
	image_url varchar(250) NOT NULL
);

CREATE TABLE quizzes (
	id int auto_increment primary key,
	subject_id int,
	name varchar(100) NOT NULL,
	foreign key (subject_id) references subjects(id)
);

CREATE TABLE links (
	id int auto_increment primary key,
	quiz_id int,
	name varchar(150),
	url varchar(500),
	foreign key (quiz_id) references quizzes(id)
);

CREATE TABLE questions (
	id int auto_increment primary key,
	quiz_id int,
	question_text varchar(200),
	option_1 varchar(250),
	option_2 varchar(250),
	option_3 varchar(250),
	answer integer,
	foreign key (quiz_id) references quizzes(id)
);

INSERT INTO subjects (name, image_url) VALUES ('Marine Life', 'https://t4.ftcdn.net/jpg/02/28/67/47/240_F_228674782_TjfB8augkK4l6NZxddFvlHHw2K7bVpbp.jpg');
INSERT INTO quizzes (name, subject_id) VALUES ('Aquatic Animals', 1);

INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'Which of the following is the largest species of shark?', 'Hammerhead Shark', 'Great White Shark', 'Whale Shark', 3);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'What is the primary food source for sea turtles?', 'Small fish', 'Jellyfish', 'Seaweed', 2);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'Which of these aquatic mammals is known for its playful behavior and intelligence?', 'Manatee', 'Dolphin', 'Walrus', 2);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'Which of the following fish can change its color to blend in with its surroundings?', 'Clownfish', 'Chameleon Fish', 'Seahorse', 3);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'What type of aquatic animal is a starfish?', 'Fish', 'Echinoderm', 'Crustacean', 2);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'What is the fastest swimming fish in the ocean?', 'Sailfish', 'Tuna', 'Barracuda', 1);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'What is the primary habitat of a penguin?', 'Tropical waters', 'Polar regions', 'Freshwater lakes', 2);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'Which of the following is not a type of whale?', 'Humpback Whale', 'Sperm Whale', 'Giant Squid', 3);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'What aquatic animal has the ability to regenerate lost limbs?', 'Lobster', 'Octopus', 'Sea Cucumber', 2);
INSERT INTO questions (quiz_id, question_text, option_1, option_2, option_3, answer) VALUES (1, 'What type of marine invertebrate is known for its stinging cells?', 'Coral', 'Jellyfish', 'Sea Anemone', 2);

INSERT INTO links (quiz_id, name, url) VALUES (1, 'What is the Biggest Shark? A Chart Shows the Diversity of Shark Sizes | Smithsonian Ocean', 'https://ocean.si.edu/ocean-life/sharks-rays/what-biggest-shark-chart-shows-diversity-shark-sizes');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Sea Turtle Diet — SEE Turtles', 'https://www.seeturtles.org/sea-turtle-diet');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Fun Facts About One of the Most Intelligent Aquatic Mammals', 'https://maddcappgames.com/blogs/news/fun-facts-about-one-of-the-most-intelligent-aquatic-mammals');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Seahorse Color-Color is Not Fixed and Changes', 'https://seahorsesavvy.com/blogs/news/seahorse-color-color-is-not-fixed-and-changes');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Are starfish really fish?', 'https://oceanservice.noaa.gov/facts/starfish.html');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'The Sailfish is the Fastest Fish in the World - Ocean Conservancy', 'https://oceanconservancy.org/blog/2021/10/28/sailfish-fastest-fish/');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Penguin Fact Sheet | Blog | Nature | PBS', 'https://www.pbs.org/wnet/nature/blog/penguin-fact-sheet/');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Humpback Whale vs Sperm Whale: What are the Differences? - AZ Animals', 'https://a-z-animals.com/blog/humpback-whale-vs-sperm-whale-what-are-the-differences/');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'TIL: How Spiny Sea Creatures Regrow Body Parts', 'https://education.nationalgeographic.org/resource/til-how-spiny-sea-creatures-regrow-body-parts/');
INSERT INTO links (quiz_id, name, url) VALUES (1, 'Phylum Cnidaria', 'https://manoa.hawaii.edu/exploringourfluidearth/biological/invertebrates/phylum-cnidaria');
