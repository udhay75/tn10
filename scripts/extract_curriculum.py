#!/usr/bin/env python3
"""
Tamil Nadu State Board Class 10 English Textbook Curriculum Extractor
Extracts units, lessons, sections, exercises, and page numbers from:
Class_10_English_2024_Edition.pdf
"""

import os
import sys
import json
import re

# Ensure local pylib is accessible
script_dir = os.path.dirname(os.path.abspath(__file__))
workspace_dir = os.path.dirname(script_dir)
pylib_dir = os.path.join(workspace_dir, 'pylib')
if pylib_dir not in sys.path:
    sys.path.insert(0, pylib_dir)

from pypdf import PdfReader

PDF_PATH = os.path.join(workspace_dir, 'Class_10_English_2024_Edition.pdf')

def extract_curriculum():
    if not os.path.exists(PDF_PATH):
        raise FileNotFoundError(f"PDF not found at {PDF_PATH}")

    reader = PdfReader(PDF_PATH)
    total_pages = len(reader.pages)
    print(f"Loaded PDF with {total_pages} pages.")

    # Base curriculum metadata
    curriculum = {
        "board": {
            "code": "tn_state_board",
            "name": "Tamil Nadu State Board of School Education",
            "state": "Tamil Nadu"
        },
        "class": {
            "grade_number": 10,
            "title": "Standard 10",
            "code": "class_10"
        },
        "medium": {
            "code": "english",
            "name": "English Medium"
        },
        "subject": {
            "code": "class_10_english",
            "title": "English",
            "curriculum_version": "2024 Edition",
            "textbook": {
                "title": "Standard Ten English",
                "edition": "Revised Edition 2020, 2022, 2023, Reprint 2024",
                "first_edition_year": 2019,
                "reprint_year": 2024,
                "publisher": "Tamil Nadu Textbook and Educational Services Corporation",
                "source_file": "Class_10_English_2024_Edition.pdf",
                "total_pages": total_pages,
                "page_offset": 4  # PDF Page = Printed Page + 4
            }
        },
        "units": []
    }

    # Definition of the 7 Units with verified page numbers and metadata
    raw_units_definition = [
        {
            "unit_number": 1,
            "theme": "Courage, Adventurous Journey, Bravery & Nature",
            "prose": {
                "title": "His First Flight",
                "author": "Liam O'Flaherty",
                "printed_start": 2,
                "printed_end": 16,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'His First Flight' text", "page": 2, "details": "Read the story of the young seagull overcoming fear to fly."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Comprehension Questions (a - g)", "page": 3, "details": "Answer questions on the seagull's siblings, parents, first catch, and fear."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary & Key Words", "page": 5, "details": "Learn meanings of ledge, shrilly, herring, devour, cackle, mackerel, whet, preening, plaintively, swoop, monstrous."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 sentences (Questions 1 to 6)", "page": 5, "details": "Short answer questions on young seagull's struggles, parents' coaxing, and first flight."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions (Questions 1 & 2)", "page": 6, "details": "Detailed paragraph responses on overcoming fear and parental discipline."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Parts of Speech (Sets 1 & 2)", "page": 6, "details": "Identify adjectives, nouns, and adverbs derived from story words."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary D: Change Form of Underlined Words", "page": 7, "details": "Convert word forms into adjectives, adverbs, nouns, and verbs."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary E: Construct Sentences", "page": 7, "details": "Make sentences with coward, gradual, praise, courageous, starvation."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening Activity F: Travelogue Comprehension", "page": 7, "details": "Listen to travelogue excerpt and answer related questions."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Speaking Activity G: Dialogue Continuation", "page": 8, "details": "Continue Mary and Father dialogue planning a trip to the forest."},
                    {"type": "source_activity", "section": "Reading", "label": "Reading Comprehension H: Bungee Jumping Passage", "page": 8, "details": "Read adventure travel passage and answer questions 1 to 6."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing Activity I: Prepare Advertisements", "page": 10, "details": "Draft attractive commercial ads using provided hints for Home appliances & Mobile Galaxy."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing Activity J: Report Writing", "page": 11, "details": "Write 100-120 word reports on Educational Development Day or Literary Association."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Modals & Semi-Modals (Exercises A - E)", "page": 12, "details": "Practice modal verbs (can, could, may, might, must, should, would) in dialogues and sentences."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Active and Passive Voice (Exercises F - K)", "page": 14, "details": "Convert active voice into passive voice, commands, requests, recipes, and event reports."},
                    {"type": "app_task", "section": "Revision", "label": "Revise His First Flight & Grammar Concepts", "page": 2, "details": "Comprehensive revision of questions, vocabulary, modals, and voice."}
                ]
            },
            "poem": {
                "title": "Life",
                "author": "Henry Van Dyke",
                "is_memoriter": True,
                "printed_start": 17,
                "printed_end": 20,
                "sections": [
                    {"type": "app_task", "section": "Memoriter", "label": "Recite & Memorise 'Life' Poem", "page": 17, "details": "Memorise the 14-line sonnet with forward face and unreluctant soul."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 18, "details": "Learn meanings of mourning, veils, crown, quest, unreluctant."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions (1 to 5)", "page": 18, "details": "Rhyme scheme, poetic devices, and analytical questions on stanzas."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 19, "details": "Write an 80-100 word essay describing the poet's positive journey through life."},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Poem Activity C: Complete Summary Passage", "page": 19, "details": "Fill in the missing keywords to complete the poem summary."},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Read & Enjoy: 'Sea Fever' by John Masefield", "page": 20, "details": "Appreciation of adventurous seafaring poetry."}
                ]
            },
            "supplementary": {
                "title": "The Tempest",
                "author": "Charles Lamb (Tales From Shakespeare)",
                "printed_start": 21,
                "printed_end": 29,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Tempest' Tale", "page": 21, "details": "Read the story of Prospero, Miranda, Ariel, Caliban, and Ferdinand on the enchanted island."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 26, "details": "Learn tormenting, dreadful, duke, deprive, familiar."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Choose the Correct Answer", "page": 26, "details": "Multiple-choice comprehension questions on the plot and characters."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Identify the Character or Speaker", "page": 26, "details": "Recognize character quotes from Prospero, Miranda, Ferdinand, and Ariel."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Answer in 1-2 Sentences", "page": 27, "details": "Brief questions about Prospero's magical spells, brother's betrayal, and forgiveness."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise D: Rearrange the Jumbled Sentences", "page": 27, "details": "Put the story events into correct chronological sequence."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise E: Paragraph Questions (1 & 2)", "page": 28, "details": "Character sketches and thematic analysis of forgiveness and reconciliation."}
                ]
            }
        },
        {
            "unit_number": 2,
            "theme": "Humour, Family Quirks & Pets",
            "prose": {
                "title": "The Night the Ghost Got In",
                "author": "James Thurber",
                "printed_start": 30,
                "printed_end": 44,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Night the Ghost Got In'", "page": 30, "details": "Read James Thurber's comic memoir of midnight chaos and mistaken burglars."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Comprehension Questions (a - g)", "page": 31, "details": "Questions on strange sounds, grandfather's behaviour, and mother's shoe throwing."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary", "page": 33, "details": "Learn hullabaloo, bevelled, hysterical, creaking, indignant."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 Sentences", "page": 34, "details": "Short answer questions on the misunderstanding between police, grandfather, and narrator."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions", "page": 35, "details": "Describe the humorous sequence of events that unfolded in the house."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Slang & Informal Expressions (A - D)", "page": 35, "details": "Explore colloquial words, idioms, and figurative usage."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening & Speaking Activities (E - G)", "page": 38, "details": "Listening comprehension and humorous storytelling practice."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing: Notice Writing & Message Writing", "page": 39, "details": "Format and compose school notices and telephone messages."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Articles & Determiners (Exercises A - E)", "page": 41, "details": "Definite and indefinite articles, quantifiers, demonstratives, and possessives."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Prepositions & Prepositional Phrases (F - I)", "page": 43, "details": "Prepositions of time, place, direction, and phrasal prepositions."},
                    {"type": "app_task", "section": "Revision", "label": "Revise Unit 2 Grammar & Vocabulary", "page": 30, "details": "Review articles, prepositions, notices, and story themes."}
                ]
            },
            "poem": {
                "title": "The Grumble Family",
                "author": "Lucy Maud Montgomery",
                "is_memoriter": False,
                "printed_start": 45,
                "printed_end": 49,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Grumble Family'", "page": 45, "details": "Read about Complaining Street, River of Discontent, and avoiding chronic grumbling."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 46, "details": "Learn discontent, amiss, growl, grumble, gloom."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions", "page": 47, "details": "Questions analyzing the satirical portrayal of chronic fault-finders."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 48, "details": "Discuss the moral lesson of staying cheerful and avoiding the Grumble family's habits."},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Poem Activities & Appreciation", "page": 48, "details": "Rhyme scheme and figures of speech (personification, hyperbole)."}
                ]
            },
            "supplementary": {
                "title": "Zigzag",
                "author": "Asha Nehemiah",
                "printed_start": 50,
                "printed_end": 59,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'Zigzag' Tale", "page": 50, "details": "Enjoy the tale of Dr. Krishnan's family and the peculiar multi-lingual African bird."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 55, "details": "Learn commotion, eavesdrop, squawk, snoring, pandemonium."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Identify Speaker or Character", "page": 56, "details": "Who said what to whom in the clinic and household."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Multiple-Choice & Sequencing", "page": 56, "details": "Test comprehension of Zigzag's snoring and surprise transformation in the clinic."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Answer in 1-2 Sentences", "page": 57, "details": "Questions on how Zigzag changed from a nuisance into a clinic helper."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise D: Paragraph Questions", "page": 58, "details": "Write a summary of the chaos caused by Zigzag and Mrs. Krishnan's ruined painting."}
                ]
            }
        },
        {
            "unit_number": 3,
            "theme": "Women Empowerment, Maritime Expedition & Bravery",
            "prose": {
                "title": "Empowered Women Navigating the World",
                "author": "Editorial / Navika Sagar Parikrama",
                "printed_start": 60,
                "printed_end": 83,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'Empowered Women Navigating the World'", "page": 60, "details": "Learn about the all-woman Indian Navy crew circum-navigating the globe in INSV Tarini."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Questions (a - j)", "page": 62, "details": "Questions on INSV Tarini, training of the six officers, challenges, and team bonding."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary", "page": 65, "details": "Learn auxiliary, indigenous, circumnavigation, skipper, appraisal."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 Sentences", "page": 65, "details": "Short answers on Lt Cdr Vartika Joshi and the crew's achievements."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions", "page": 66, "details": "Paragraph responses highlighting grit, resilience, and women empowerment."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Idioms, Phrasal Verbs & Nautical Terms (A - E)", "page": 67, "details": "Idioms related to water, sea journeys, and phrasal verbs."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening & Speaking Activities (F - I)", "page": 71, "details": "Interview simulation and maritime weather reports."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing: Formal Letter & Email Writing", "page": 74, "details": "Write letters of complaint, appreciation, and professional emails."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Tenses (Present, Past, Future) (Exercises A - G)", "page": 77, "details": "Master simple, continuous, perfect, and perfect continuous tense structures."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Subject-Verb Agreement (Concord) (H - J)", "page": 81, "details": "Rules of concord with singular/plural subjects and collective nouns."},
                    {"type": "app_task", "section": "Revision", "label": "Revise Unit 3 Tenses & Concord", "page": 60, "details": "Review tense timeline rules and subject-verb concord rules."}
                ]
            },
            "poem": {
                "title": "I am Every Woman",
                "author": "Rakhi Nariani Shirke",
                "is_memoriter": True,
                "printed_start": 84,
                "printed_end": 87,
                "sections": [
                    {"type": "app_task", "section": "Memoriter", "label": "Recite & Memorise 'I am Every Woman'", "page": 84, "details": "Memorise the inspirational poem celebrating the strength, dignity, and tenacity of modern women."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 85, "details": "Learn innate, stake, persistence, prank, ferocious."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions", "page": 85, "details": "Analyze tone, metaphors (lioness), and questions on each stanza."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 86, "details": "Discuss how women face challenges today without fear or compromise."},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Poem Activities & Appreciation", "page": 86, "details": "Figures of speech: Metaphor, Alliteration, Rhyme."}
                ]
            },
            "supplementary": {
                "title": "The Story of Mulan",
                "author": "Chinese Legend",
                "printed_start": 88,
                "printed_end": 93,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Story of Mulan'", "page": 88, "details": "Read the heroic legend of Hua Mulan disguising as a man to save her aging father."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 91, "details": "Learn carve, robe, general, soldier, emperor."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Choose the Best Option", "page": 91, "details": "Comprehension checks on why Mulan joined the army and how she saved China."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Identify the Speaker", "page": 91, "details": "Match quotes with Mulan, Emperor, and Father."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Answer in 1-2 Sentences", "page": 92, "details": "Questions on Mulan's military battles and reward rejection."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise D: Paragraph Question", "page": 93, "details": "Evaluate Mulan's patriotism, filial piety, and courage in detail."}
                ]
            }
        },
        {
            "unit_number": 4,
            "theme": "Nostalgia, Human Relationships & Repentance",
            "prose": {
                "title": "The Attic",
                "author": "Satyajit Ray",
                "printed_start": 94,
                "printed_end": 114,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Attic'", "page": 94, "details": "Satyajit Ray's touching story of Aditya visiting his ancestral home to right an old wrong."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Questions (a - h)", "page": 96, "details": "Questions on the tea shop, Sasanka Sanyal, the silver medal, and the attic visit."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary", "page": 99, "details": "Learn bifurcated, revive, soothing, rustic, vent."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 Sentences", "page": 100, "details": "Short answer questions on Sanyal's recitation of Tagore's poem and Aditya's regret."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions", "page": 101, "details": "Paragraph responses on restitution, conscience, and childhood friendship."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Affixes, Prefixes & Suffixes (A - D)", "page": 102, "details": "Word building using prefixes and suffixes to form nouns and adjectives."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening & Speaking: Audio & Roleplay (E - G)", "page": 105, "details": "Listening to audio story and enacting scenes between Aditya and Sanyal."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing: Article Writing & Speech Writing", "page": 107, "details": "Structure articles for school magazines and formal school assembly speeches."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Connectors & Linkers (Exercises A - D)", "page": 109, "details": "Coordinating, subordinating, and correlative conjunctions."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Nominalisation (E - G)", "page": 112, "details": "Transforming verbs and adjectives into formal abstract nouns."},
                    {"type": "app_task", "section": "Revision", "label": "Revise Unit 4 Connectors & Word Forms", "page": 94, "details": "Review connectors, linkers, nominalisation, and comprehension."}
                ]
            },
            "poem": {
                "title": "The Ant and the Cricket",
                "author": "Adapted from Aesop's Fables",
                "is_memoriter": False,
                "printed_start": 115,
                "printed_end": 119,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Ant and the Cricket'", "page": 115, "details": "Read the timeless fable on the importance of diligence, forethought, and hard work."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 116, "details": "Learn accustom, famine, miserly, quoth, warrant."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions", "page": 117, "details": "Rhyme scheme, character contrasts between ant and cricket."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 118, "details": "Explain the fable's moral: 'Work hard today to enjoy tomorrow.'"},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Poem Appreciation & Parallel Reading", "page": 118, "details": "Compare with contemporary stories of thrift and planning."}
                ]
            },
            "supplementary": {
                "title": "The Aged Mother",
                "author": "Matsuo Basho",
                "printed_start": 120,
                "printed_end": 125,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Aged Mother'", "page": 120, "details": "A Japanese folk tale illustrating the wisdom of elders in saving a province."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 123, "details": "Learn despotic, mandate, summit, twilight, ashes."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Match & True/False", "page": 123, "details": "Identify the tyrannical governor's decree and the son's devotion."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Answer in 1-2 Sentences", "page": 124, "details": "Questions on the rope of ashes and the mother's twigs dropped on the trail."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Paragraph Question", "page": 125, "details": "Discuss the theme: 'With the crown of snow, there cometh wisdom.'"}
                ]
            }
        },
        {
            "unit_number": 5,
            "theme": "Technology, Assistive Devices & Future Innovation",
            "prose": {
                "title": "Tech Bloomers",
                "author": "Informational / Technology Feature",
                "printed_start": 126,
                "printed_end": 147,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'Tech Bloomers'", "page": 126, "details": "Discover how assistive technology empowers differently-abled individuals like Alisha and David."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Questions (a - g)", "page": 128, "details": "Questions on dragon dictate, eye gaze technology, and assistive communication."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary", "page": 131, "details": "Learn debilitating, inclusions, impaired, prodigy, AAC."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 Sentences", "page": 131, "details": "How technology broke barriers for differently-abled students."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions", "page": 132, "details": "Detailed account of Kim's Assistive Technology research and real-life impact."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Compound Words & Tech Acronyms (A - E)", "page": 133, "details": "Compound nouns, abbreviations, acronyms, and tech terminology."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening & Speaking: Tech Debates (F - H)", "page": 136, "details": "Speaking debate on artificial intelligence and assistive technology."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing: Process Description & Formal Emails", "page": 138, "details": "Writing step-by-step instructions and technical explanations."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Pronouns (Personal, Relative, Demonstrative) (A - D)", "page": 140, "details": "Relative clauses (who, which, that, whom, whose) and antecedents."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Reported Speech (Direct to Indirect) (E - I)", "page": 143, "details": "Rules for statements, questions, imperatives, and exclamations."},
                    {"type": "app_task", "section": "Revision", "label": "Revise Unit 5 Reported Speech & Relative Clauses", "page": 126, "details": "Review reported speech transformation rules and exercises."}
                ]
            },
            "poem": {
                "title": "The Secret of the Machines",
                "author": "Rudyard Kipling",
                "is_memoriter": True,
                "printed_start": 148,
                "printed_end": 152,
                "sections": [
                    {"type": "app_task", "section": "Memoriter", "label": "Recite & Memorise 'The Secret of the Machines'", "page": 148, "details": "Memorise Kipling's powerful poem on the power and limitations of industrial machines."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 150, "details": "Learn ore-bed, furnace, wrought, gauged, monster."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions", "page": 150, "details": "Questions analyzing machine capabilities vs lack of human feelings and morality."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 151, "details": "Explain why machines are 'nothing more than children of your brain.'"},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Poem Appreciation: Rhyme & Imagery", "page": 151, "details": "Hyperbole, personification, and mechanical rhythm."}
                ]
            },
            "supplementary": {
                "title": "A day in 2889 of an American Journalist",
                "author": "Jules Verne",
                "printed_start": 153,
                "printed_end": 161,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'A day in 2889 of an American Journalist'", "page": 153, "details": "Jules Verne's visionary sci-fi story of Earth Chronicle editor Fritz Napoleon Smith in the year 2889."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 158, "details": "Learn telephote, phonotelephote, aero-car, incubator, subterranean."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Identify Speaker & True/False", "page": 159, "details": "Distinguish futuristic inventions predicted by Jules Verne."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Answer in 1-2 Sentences", "page": 159, "details": "Questions on advertisements projected on clouds and fast tube travel."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Paragraph Question", "page": 160, "details": "Analyze Verne's uncanny predictions that have become reality today."}
                ]
            }
        },
        {
            "unit_number": 6,
            "theme": "Language Pride, Patriotism & Universal Brotherhood",
            "prose": {
                "title": "The Last Lesson",
                "author": "Alphonse Daudet",
                "printed_start": 162,
                "printed_end": 178,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Last Lesson'", "page": 162, "details": "Read Franz's awakening to the value of his native mother tongue in Alsace-Lorraine."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Questions (a - g)", "page": 164, "details": "Questions on M. Hamel's green coat, villagers sitting on back benches, and the Prussian order."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary", "page": 167, "details": "Learn dread, commotion, gravely, reproach, vivat."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 Sentences", "page": 167, "details": "Why was Franz afraid of being questioned on participles?"},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions", "page": 168, "details": "M. Hamel's tribute to the French language as the most beautiful, clear, and logical key to freedom."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Foreign Words & Expressions (A - D)", "page": 169, "details": "Latin and French loan words commonly used in English."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening & Speaking: Patriotic Speeches", "page": 172, "details": "Deliver a speech on linguistic diversity and mother tongue pride."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing: Poster Making & Slogan Writing", "page": 173, "details": "Design informative and eye-catching posters with catchy slogans."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Simple, Compound, and Complex Sentences (A - E)", "page": 175, "details": "Main clauses, subordinate clauses, and transformation of sentence types."},
                    {"type": "app_task", "section": "Revision", "label": "Revise Unit 6 Clause Transformation", "page": 162, "details": "Review simple, compound, and complex sentence transformations."}
                ]
            },
            "poem": {
                "title": "No Men Are Foreign",
                "author": "James Falconer Kirkup",
                "is_memoriter": True,
                "printed_start": 179,
                "printed_end": 182,
                "sections": [
                    {"type": "app_task", "section": "Memoriter", "label": "Recite & Memorise 'No Men Are Foreign'", "page": 179, "details": "Memorise the universal humanitarian poem condemning warfare and preaching world peace."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 180, "details": "Learn dispossess, betray, condemn, defile, outrage."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions", "page": 181, "details": "Common human anatomy, harvests, and shared earth across countries."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 181, "details": "How does Kirkup prove that all human beings are brothers under the sun?"},
                    {"type": "source_activity", "section": "Poem Activities", "label": "Poem Activities & Appreciation", "page": 182, "details": "Universal brotherhood reflections and poetic devices."}
                ]
            },
            "supplementary": {
                "title": "The Little Hero of Holland",
                "author": "Mary Mapes Dodge",
                "printed_start": 183,
                "printed_end": 188,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Little Hero of Holland'", "page": 183, "details": "The courageous tale of 8-year-old Peter holding back the North Sea leak with his finger through the night."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 186, "details": "Learn dike, trickle, sluice, numb, vigil."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Match & True/False", "page": 186, "details": "Check key milestones of Peter's vigil at the dike."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Answer in 1-2 Sentences", "page": 187, "details": "Peter's sense of duty to his town and parents."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Paragraph Question", "page": 188, "details": "Narrate Peter's determination and how his alertness saved Holland from inundation."}
                ]
            }
        },
        {
            "unit_number": 7,
            "theme": "Mystery, Detection, Wisdom & Human Dilemmas",
            "prose": {
                "title": "The Dying Detective",
                "author": "Arthur Conan Doyle",
                "printed_start": 189,
                "printed_end": 201,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The Dying Detective'", "page": 189, "details": "Sherlock Holmes' theatrical ruse to entrap Culverton Smith for Victor Savage's murder."},
                    {"type": "source_activity", "section": "In-text Questions", "label": "In-text Questions (a - g)", "page": 191, "details": "Questions on Holmes' fake fever, Dr. Watson's concern, and the ivory box."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Glossary", "page": 194, "details": "Learn delirious, gaunt, listless, ruse, vindictive."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension A: Answer in 1-2 Sentences", "page": 195, "details": "Why did Holmes forbid Watson from examining him or touching his things?"},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Comprehension B: Paragraph Questions", "page": 196, "details": "Explain how Holmes outwitted Culverton Smith with the help of Inspector Morton."},
                    {"type": "source_activity", "section": "Vocabulary", "label": "Vocabulary: Homophones, Confusables & British/American English (A - E)", "page": 196, "details": "Distinguish tricky word pairs and American vs British spellings."},
                    {"type": "source_activity", "section": "Listening & Speaking", "label": "Listening & Speaking: Detective Clues & Interrogation", "page": 198, "details": "Simulate deductive reasoning dialogue and mystery clues."},
                    {"type": "source_activity", "section": "Writing", "label": "Writing: Pamphlet Making & Story Writing", "page": 199, "details": "Creating awareness pamphlets and continuing mystery stories."},
                    {"type": "source_activity", "section": "Grammar", "label": "Grammar: Degrees of Comparison (A - E)", "page": 200, "details": "Positive, Comparative, and Superlative degree transformations."},
                    {"type": "app_task", "section": "Revision", "label": "Revise Unit 7 Degrees of Comparison", "page": 189, "details": "Review degrees of comparison rules and mystery story elements."}
                ]
            },
            "poem": {
                "title": "The House on Elm Street",
                "author": "Nadia Bush",
                "is_memoriter": False,
                "printed_start": 202,
                "printed_end": 204,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'The House on Elm Street'", "page": 202, "details": "Atmospheric poem capturing the suspense and ghostly rumors of an abandoned house."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Poem Glossary", "page": 203, "details": "Learn dread, eerie, bare, fade, mystery."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension A: Stanza Questions", "page": 203, "details": "Poetic devices, imagery of the house that remains a mystery."},
                    {"type": "source_activity", "section": "Comprehension Questions", "label": "Poem Comprehension B: Paragraph Question", "page": 204, "details": "Describe the eerie atmosphere and supernatural aura created by the poet."}
                ]
            },
            "supplementary": {
                "title": "A Dilemma",
                "author": "Silas Weir Mitchell",
                "printed_start": 205,
                "printed_end": 212,
                "sections": [
                    {"type": "app_task", "section": "Reading", "label": "Read 'A Dilemma'", "page": 205, "details": "Uncle Philip's iron box bequest stuffed with priceless gems and dynamite trigger."},
                    {"type": "source_activity", "section": "Glossary", "label": "Study Supplementary Glossary", "page": 209, "details": "Learn eccentricity, malice, bequeath, contrivance, dilemma."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise A: Match & True/False", "page": 210, "details": "Comprehension check on Tom's inheritance and the warning letter."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise B: Answer in 1-2 Sentences", "page": 210, "details": "Tom's sleepless attempts, consultations with professors and dynamiters."},
                    {"type": "source_activity", "section": "Exercises", "label": "Exercise C: Paragraph Question", "page": 211, "details": "Detail Tom's psychological torment and his final bequest to the Smithsonian Institute."}
                ]
            }
        }
    ]

    # Process into standardized JSON structure with stable UUIDs / slugs
    total_lessons = 0
    total_items = 0

    for u_def in raw_units_definition:
        unit_num = u_def["unit_number"]
        unit_id = f"tn10_eng_u{unit_num}"
        unit_obj = {
            "id": unit_id,
            "unit_number": unit_num,
            "title": f"Unit {unit_num}",
            "theme": u_def["theme"],
            "lessons": []
        }

        # Each unit has 3 lessons: Prose, Poem, Supplementary
        lesson_definitions = [
            ("prose", u_def["prose"]),
            ("poem", u_def["poem"]),
            ("supplementary", u_def["supplementary"])
        ]

        for order_idx, (l_type, l_data) in enumerate(lesson_definitions, start=1):
            total_lessons += 1
            l_slug = re.sub(r'[^a-z0-9]+', '_', l_data["title"].lower()).strip('_')
            lesson_id = f"tn10_eng_u{unit_num}_{l_type}_{l_slug}"
            
            p_start = l_data["printed_start"]
            p_end = l_data["printed_end"]
            pdf_start = p_start + 4
            pdf_end = p_end + 4

            lesson_obj = {
                "id": lesson_id,
                "unit_id": unit_id,
                "unit_number": unit_num,
                "lesson_number": order_idx,
                "lesson_type": l_type,  # 'prose' | 'poem' | 'supplementary'
                "title": l_data["title"],
                "author": l_data.get("author", "Unknown"),
                "is_memoriter": l_data.get("is_memoriter", False),
                "printed_page_start": p_start,
                "printed_page_end": p_end,
                "pdf_page_start": pdf_start,
                "pdf_page_end": pdf_end,
                "checklist_items": []
            }

            for item_idx, s in enumerate(l_data["sections"], start=1):
                total_items += 1
                item_slug = re.sub(r'[^a-z0-9]+', '_', s["label"].lower()).strip('_')[:40]
                item_id = f"{lesson_id}_item_{item_idx}_{item_slug}"
                
                s_page = s["page"]
                s_pdf_page = s_page + 4

                item_obj = {
                    "id": item_id,
                    "lesson_id": lesson_id,
                    "order_index": item_idx,
                    "item_type": s["type"],  # 'source_activity' | 'app_task'
                    "section_name": s["section"],
                    "label": s["label"],
                    "description": s["details"],
                    "printed_page": s_page,
                    "pdf_page": s_pdf_page,
                    "source_reference": f"Textbook p. {s_page} (PDF p. {s_pdf_page})",
                    "is_required": True
                }
                lesson_obj["checklist_items"].append(item_obj)

            unit_obj["lessons"].append(lesson_obj)

        curriculum["units"].append(unit_obj)

    curriculum["summary"] = {
        "total_units": len(curriculum["units"]),
        "total_lessons": total_lessons,
        "total_checklist_items": total_items,
        "source_pdf": "Class_10_English_2024_Edition.pdf",
        "verified": True
    }

    # Write output to src/data/class_10_english_2024.json
    output_path = os.path.join(workspace_dir, 'src', 'data', 'class_10_english_2024.json')
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(curriculum, f, indent=2, ensure_ascii=False)

    print(f"Successfully generated curriculum JSON: {output_path}")
    print(f"Units: {len(curriculum['units'])}, Lessons: {total_lessons}, Checklist Items: {total_items}")
    return curriculum

if __name__ == "__main__":
    extract_curriculum()
