:- consult('Logic.pl').

:- discontiguous noun/3.
:- discontiguous synonym/1.

/* ---------------- Lexicon ---------------- */

pronoun(yo).
% pronoun(me).
pronoun(mi).

reflexivePronoun(me).

verb(amo, positive).
verb(adoro, positive).
verb(agrada, positive).
verb(agradan, positive).
verb(gusta, positive).
verb(gustan, positive).
verb(disfruto, positive).
verb(encanta, positive).
verb(encantan, positive).
verb(intereso, positive).
verb(interesa, positive).
verb(interesan, positive).

verb(odio, negative).
verb(detesto, negative).
verb(disgusta, negative).
verb(disgustan, negative).

verb(soy, positive).
verb(considero, positive).

verb(tengo, positive).
verb(suelo, positive).
verb(quiero, positive).

verb(parece, positive).

verb(oigo, positive).
verb(escucho, positive).

verb(disecar, positive).
verb(operar, positive).
verb(abrir, positive).

verb(ordenar, positive).


    % For copulative sentences, an adjective will be allowed as the first word in the noun phrase of the verb phrase.
    % If the verb is soy, this adjective will be taken as the target and if the sentence didn't end after it an error is raised.

adverb(mucho).
adverb(muy).
adverb(si).
adverb(siempre).
adverb(generalmente).
adverb(ocasionalmente).
adverb(frecuentemente).

adverb(no).

preposition(a).
preposition(por).
preposition(para).
preposition(con).
preposition(de).
preposition(en).


% genitivePreposition(de).
% genitivePreposition(desde).
% % genitivePreposition(none).

determiner(la, feminine, singular).
determiner(el, masculine, singular).
determiner(las, feminine, plural).
determiner(los, masculine, plural).

determiner(una, feminine, singular).
determiner(un, masculine, singular).
determiner(unas, feminine, plural).
determiner(unos, masculine, plural).
% determiner(none, none, none).


/* Traits that require determiner */

% determiner_trait(matematicas).
% determiner_trait(matematica).
% determiner_trait(tecnologia).
% determiner_trait(personas).
% determiner_trait(biologia).
noun(matematica, matematicas, feminine).
noun(numero, numeros, masculine).
noun(trigonometria, trigonometrias, feminine).
noun(geometria, geometrias, feminine).
noun(funcion, funciones, feminine).
synonym([matematica, numero, resolver, resuelvo, trigonometria, geometria, funcion]).
% Synonyms can include words of other types like adjectives and infinitives.
% Synonyms are defined by their first declension according to firstDeclension/2

noun(tecnologia, tecnologias, feminine).
noun(computadora, computadoras, feminine).
noun(hardware, hardwares, masculine).
noun(software, softwares, masculine).
noun(juego, juegos, masculine).
noun(automatizacion, automatizaciones, feminine).
noun(internet, internets, masculine).
synonym([tecnologia, computadora, hardware, software, juego, automatizacion, internet]).

noun(persona, personas, feminine).
noun(gente, gentes, feminine).
noun(sociedad, sociedades, feminine).
synonym([persona, gente, sociedad]).


noun(biologia, biologias, feminine).
noun(animal, animales, masculine).
noun(criatura, criaturas, feminine).
noun(planta, plantas, feminine).
noun(arbol, arboles, masculine).
synonym([biologia, animal, criatura, planta, arbol]).


noun(empatia, empatias, feminine).
synonym([empatia, empatico]).

noun(problema, problemas, masculine).

noun(disciplina, disciplinas, feminine).
noun(orden, ordenes, masculine).
noun(aseo, aseos, masculine).
noun(constancia, constancias, feminine).
noun(perseverancia, perseverancia, masculine).
synonym([disciplina, orden, aseo, constancia, perseverancia, disciplinado, ordenado, aseado, constante, perseverante, ordenar]).


synonym([escuchar, escucho, oir, oigo, atento]).

% synonym([escuchar, escucho, oir, oigo, atento]).


% Arity 1 noun rule to check if a noun exists.
noun(Noun):-
    noun(Noun,_,_).
noun(Noun):-
    noun(_,Noun,_).



infinitive(escuchar).
infinitive(oir).
infinitive(resolver).
infinitive(hacer).
infinitive(trabajar).

infinitive(ser).
infinitive(tener).
infinitive(parecer).



% If a verb phrase with a verb that contains an infinitive does not have a noun phrase, then the infinitive must be the target.

adjective(empatico, empatica, empaticos, empaticas).

adjective(demas, demas, demas, demas).
adjective(otro, otra, otros, otras).

adjective(bueno, buena, buenos, buenas).
adjective(buen, buena, buenos, buenas).

adjective(atento, atenta, atentos, atentas).

adjective(disciplinado, disciplinada, disciplinados, disciplinadas).
adjective(ordenado, ordenada, ordenados, ordenadas).
adjective(aseado, aseada, aseados, aseadas).
adjective(constante, constante, constantes, constantes).
adjective(perseverante, constante, constantes, constantes).


% Rule to get the declension of any noun.
nounDeclension(Noun, Gender, singular) :- noun(Noun,_,Gender).
nounDeclension(Noun, Gender, plural) :- noun(_,Noun,Gender).   

% Relates Word to WordFirst depending on what part of speech Word is:
% Nouns: WordFirst is the singular.
firstDeclension(Word, WordFirst):-
    noun(WordFirst, Word, _).
firstDeclension(Word, Word):-
    noun(Word, _, _).
% Adjectives: WordFirst is the singular masculine.
firstDeclension(Word, WordFirst):-
    adjective(WordFirst, _, _, Word).
firstDeclension(Word, WordFirst):-
    adjective(WordFirst, _, Word,_).
firstDeclension(Word, WordFirst):-
    adjective(WordFirst, Word, _, _).
firstDeclension(Word, Word):-
    adjective(Word, _, _, _).
% Nondeclinable words: WordFirst is itself.
firstDeclension(Word, Word):-
    infinitive(Word).

% Relates a word to any of its synonyms.
% A word is a synonym of itself.
isSynonym(Synonym, Synonym).
isSynonym(Synonym1, Synonym2):-
    firstDeclension(Synonym1, Synonym1FirstDeclension),
    synonym(ListOfSynonyms),
    member(Synonym1FirstDeclension, ListOfSynonyms),
    member(Synonym2, ListOfSynonyms).

% Rule to get the declension of any adjective.
adjectiveDeclension(Adjective, masculine, singular) :- adjective(Adjective, _, _, _).
adjectiveDeclension(Adjective, feminine, singular) :- adjective(_, Adjective, _, _).
adjectiveDeclension(Adjective, masculine, plural)   :- adjective(_, _, Adjective, _).
adjectiveDeclension(Adjective, feminine, plural)   :- adjective(_, _, _, Adjective).    


% ------------------ Recursive BNF with list differences. ------------------

% Noun phrase:
    % [determiner, pronoun, adjective_before, noun, adjective_after]

% Describes the list difference between Words and WordsAfter where the variables extracted syntactically correspond to the possible words of a noun phrase.
% Relates the Words given to WordsAfter from which all of the variables have been extracted. 
% nounPhrase([], [], none, none, none, none, none).
nounPhrase(WordsAfter, Words, Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after):-
    prepositionLD(Preposition, Words0, Words),
    determinerLD(Determiner, Words1, Words0),                           % where: Determiner if found; Words1, Words0 minus the determiner; Words0.
    pronounLD(Pronoun, Words2, Words1),                                % 
    adverbLD(Adverb_before, Words3, Words2),                                       % adverbs are unused since they are undeclinable and are almost always gramatically correct.
    adjectiveLD(Adjective_before, Words4, Words3),                     % 
    nounLD(Noun, Words5, Words4),                                      % 
    adverbLD(Adverb_after, Words6, Words5),                                       % adverbs are unused since they are undeclinable and are almost always gramatically correct.
    adjectiveLD(Adjective_after, WordsAfter, Words6).                  % 
nounPhrase(Words, Words, none, none, none, none, none, none).   % No matches with a non empty list.


% % Relates a list of words possibly starting with a genitivePreposition to the list of words without it and GenitivePreposition is the word if found or none otherwise.
% % genitivePrepositionLD(none, [], []).
% genitivePrepositionLD(GenitivePreposition, WordsAfter, [WordsFirst|WordsRest]):-
%     genitivePreposition(WordsFirst),
%     WordsAfter = WordsRest,
%     GenitivePreposition = WordsFirst,
%     !.
% genitivePrepositionLD(none, Words, Words).

% Relates a list of words possibly starting with a determiner to the list of words without it and Determiner is the word if found or none otherwise.
% determinerLD(none, [], []).
determinerLD(Determiner, WordsAfter, [WordsFirst|WordsRest]):-
    determiner(WordsFirst, _, _),
    WordsAfter = WordsRest,
    Determiner = WordsFirst,
    !.
determinerLD(none, Words, Words).

% % Relates a list of words possibly starting with a quantifier to the list of words without it and Quantifier is the word if found or none otherwise.
% % quantifierLD(none, [], []).
% quantifierLD(Quantifier, WordsAfter, [WordsFirst|WordsRest]):-
%     quantifier(WordsFirst, _, _, _),
%     WordsAfter = WordsRest,
%     Quantifier = WordsFirst,
%     !.
% quantifierLD(none, Words, Words).

% Relates a list of words possibly starting with a pronoun to the list of words without it and Pronoun is the word if found or none otherwise.
% pronounLD(none, [], []).
pronounLD(Pronoun, WordsAfter, [WordsFirst|WordsRest]):-
    pronoun(WordsFirst),
    WordsAfter = WordsRest,
    Pronoun = WordsFirst,
    !.
pronounLD(none, Words, Words).

% Relates a list of words possibly starting with an adjective to the list of words without it and Adjective is the word if found or none otherwise.
% adjectiveLD(none, [], []).
adjectiveLD(Adjective, WordsAfter, [WordsFirst|WordsRest]):-
    adjective(WordsFirst, _, _, _),
    WordsAfter = WordsRest,
    Adjective = WordsFirst,
    !.
adjectiveLD(Adjective, WordsAfter, [WordsFirst|WordsRest]):-
    adjective(_,WordsFirst,_,_),
    WordsAfter = WordsRest,
    Adjective = WordsFirst,
    !.
adjectiveLD(Adjective, WordsAfter, [WordsFirst|WordsRest]):-
    adjective(_,_,WordsFirst,_),
    WordsAfter = WordsRest,
    Adjective = WordsFirst,
    !.
adjectiveLD(Adjective, WordsAfter, [WordsFirst|WordsRest]):-
    adjective(_,_,_,WordsFirst),
    WordsAfter = WordsRest,
    Adjective = WordsFirst,
    !.
adjectiveLD(none, Words, Words).

% Relates a list of words possibly starting with a noun to the list of words without it and Noun is the word if found or none otherwise.
% nounLD(none, [], []).
nounLD(Noun, WordsAfter, [WordsFirst|WordsRest]):-
    noun(WordsFirst,_,_),
    WordsAfter = WordsRest,
    Noun = WordsFirst,
    !.
nounLD(Noun, WordsAfter, [WordsFirst|WordsRest]):-
    noun(_,WordsFirst,_),
    WordsAfter = WordsRest,
    Noun = WordsFirst,
    !.
nounLD(none, Words, Words).



% Relates a difference list to all the individual parts of a noun phrase.
nounPhraseLD(NounPhraseLD, Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after):-
    NounPhraseLD =        [Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after].

% Verb phrase:
    % [adverb_before, relfexive_pronoun, verb, adverb_before_infinitive, preposition_before_infinitive, infinitive, adverb_after, preposition_a, noun_phrase_a]

% Describes the list difference between Words and WordsAfter where the variables extracted syntactically correspond to the possible words and noun phrases of a verb phrase.
% Relates the Words given to WordsAfter from which all of the variables have been extracted. 
% Only the parts of the verb phrase that are used in grammar check or are needed to find the target are present in the relation.
verbPhrase([], [], none, none, none, none, none, none, none).
verbPhrase(WordsAfter, Words, Adverb_before, ReflexivePronoun, Verb, Infinitive, NounPhrase):-
    adverbLD(Adverb_before, Words0, Words),                               % where: GenitivePreposition if found; Words0, total of words minus preposition; Words.
    reflexivePronounLD(ReflexivePronoun, Words1, Words0),
    verbLD(Verb, Words2, Words1),                                        % where: Determiner if found; Words1, Words0 minus the determiner; Words0.
    adverbLD(_, Words3, Words2),                                % ...
    prepositionLD(_, Words4, Words3),
    infinitiveLD(Infinitive, Words5, Words4),
    prepositionLD(_, Words6, Words5),                                % 
    nounPhrase(WordsAfter, Words6, Preposition, Determiner, Pronoun, Adverb_beforeOfNounPhrase, Adjective_before, Noun, Adverb_after, Adjective_after),  % Describes the list difference for NounPhrase.
    nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adverb_beforeOfNounPhrase, Adjective_before, Noun, Adverb_after, Adjective_after).  % Equals the list difference to NounPhrase.
verbPhrase(Words, Words, none, none, none, none, none, [none, none, none, none, none, none, none, none]). % No matches with a non empty list.
    
% Relates a list of words possibly starting with an adverb to the list of words without it and Adverb is the word if found or none otherwise.
% adverbLD(none, [], []).
adverbLD(Adverb, WordsAfter, [WordsFirst|WordsRest]):-
    adverb(WordsFirst),
    WordsAfter = WordsRest,
    Adverb = WordsFirst,
    !.
adverbLD(none, Words, Words).

% Relates a list of words possibly starting with a verb to the list of words without it and verb is the word if found or none otherwise.
% verbLD(none, [], []).
verbLD(Verb, WordsAfter, [WordsFirst|WordsRest]):-
    verb(WordsFirst,_),
    WordsAfter = WordsRest,
    Verb = WordsFirst,
    !.
verbLD(none, Words, Words). % At least one verb must be found.

% Relates a list of words possibly starting with a preposition to the list of words without it and Preposition is the word if found or none otherwise.
% prepositionLD(none, [], []).
prepositionLD(Preposition, WordsAfter, [WordsFirst|WordsRest]):-
    preposition(WordsFirst),
    WordsAfter = WordsRest,
    Preposition = WordsFirst,
    !.
prepositionLD(none, Words, Words).

% Relates a list of words possibly starting with a reflexive pronoun to the list of words without it and ReflexivePronoun is the word if found or none otherwise.
% reflexivePronounLD(none, [], []).
reflexivePronounLD(ReflexivePronoun, WordsAfter, [WordsFirst|WordsRest]):-
    reflexivePronoun(WordsFirst),
    WordsAfter = WordsRest,
    ReflexivePronoun = WordsFirst,
    !.
reflexivePronounLD(none, Words, Words).

% Relates a list of words possibly starting with an infinitive to the list of words without it and Infinitive is the word if found or none otherwise.
% infinitiveLD(none, [], []).
infinitiveLD(Infinitive, WordsAfter, [WordsFirst|WordsRest]):-
    infinitive(WordsFirst),
    WordsAfter = WordsRest,
    Infinitive = WordsFirst,
    !.
infinitiveLD(none, Words, Words).

% Relates a difference list to all the individual parts of a verb phrase.
verbPhraseLD(VerbPhraseLD, Adverb_before, ReflexivePronoun, Verb, Infinitive, NounPhrase):-
    VerbPhraseLD =        [Adverb_before, ReflexivePronoun, Verb, Infinitive, NounPhrase].

% Sentence:
    % [noun_phrase, verb_phrase]

% Describes the list difference between Words and WordsAfter
% where the variables extracted syntactically correspond to the noun phrase and the verb phrase of a sentence.
% The two resulting lists syntactically analize the sentence.
% Words is the user's input and WordsAfter should be an empty list after the syntactical analysis.
% sentence([], [], [none, none, none, none, none, none, none, none], [none, none, none, none, [none, none, none, none, none, none, none, none], none, [none, none, none, none, none, none, none, none]]). % No words make empty noun and verb phrases.
sentence(WordsAfter, Words, NounPhrase, VerbPhrase):-
    % The noun phrase of the subject only accepts pronouns.
    nounPhrase(Words0, Words, Preposition, Determiner, Pronoun, none, none, none, none, none),
    nounPhraseLD(NounPhrase,  Preposition, Determiner, Pronoun, none, none, none, none, none),

    verbPhrase(WordsAfter, Words0,  Adverb_before, ReflexivePronoun, Verb, Infinitive, NounPhraseOfVerbPhrase),
    verbPhraseLD(VerbPhrase,        Adverb_before, ReflexivePronoun, Verb, Infinitive, NounPhraseOfVerbPhrase).
sentence(Words, Words, [none, none, none, none, none, none, none, none], [none, none, none, [none, none, none, none, none, none, none, none]]).

sentenceLD(SentenceLD, NounPhrase, VerbPhrase):-
    SentenceLD =      [NounPhrase, VerbPhrase].



% A rule that holds if declension is consistent within Sentence.  
% Sentence is a sentenceLD(Sentence, NounPhrase, VerbPhrase)
sentenceIsGrammatical(Sentence):-
    sentenceLD(Sentence, NounPhrase, VerbPhrase),
    % nounPhraseIsGrammatical(NounPhrase),  % The noun phrase is not analyzed
    verbPhraseIsGrammatical(VerbPhrase).



% A rule that holds if declension is consistent within NounPhrase.  
% NounPhrase is a nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adjective_before, Noun, Adjective_after)
% An empty NounPhrase is grammatical.
nounPhraseIsGrammatical(NounPhrase):-
    NounPhrase = [none, none, none, none, none, none, none, none].
nounPhraseIsGrammatical(NounPhrase):-
    nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after),
    determinerAndNounAgree(Determiner, Noun),    
    adjectiveAndNounAgree(Adjective_before, Noun),
    nounAndPronounDontClash(Noun, Pronoun),
    pronounIsObliqueAfterPreposition(Preposition, Pronoun),
    adjectiveAndNounAgree(Adjective_after, Noun).

% A rule that holds if the declension of a determiner matches that of the noun or there is no determiner.  
determinerAndNounAgree(Determiner, Noun):-
    determiner(Determiner, Gender, Number),
    nounDeclension(Noun, Gender, Number).
determinerAndNounAgree(Determiner, _):-
    Determiner = none.
% determinerAndNounAgree(Determiner, Noun):-
%     Determiner = none,
%     Noun = none.

% A rule that holds if the declension of an adjective matches that of the noun, there is no adjective, or there is no noun (in which case the adjective is asumed to belong to the subject).
adjectiveAndNounAgree(Adjective, Noun):-
    adjectiveDeclension(Adjective, Gender, Number),
    nounDeclension(Noun, Gender, Number).
adjectiveAndNounAgree(Adjective, _):-
    Adjective = none.
adjectiveAndNounAgree(Adjective, Noun):-
    Noun = none.
%     Adjective = none,

% A rule that holds as long as there is not both a noun and a pronoun.
nounAndPronounDontClash(Noun, Pronoun):-
    Pronoun = none,
    noun(Noun).
nounAndPronounDontClash(Noun, Pronoun):-
    Noun = none,
    pronoun(Pronoun).
nounAndPronounDontClash(Noun, Pronoun):-
    Noun = none,
    Pronoun = none.

% A rule that holds if the pronoun is none or the preposition is a and the pronoun is mi or preposition is none and pronoun is yo. 
pronounIsObliqueAfterPreposition(_, Pronoun):-
    Pronoun = none.
pronounIsObliqueAfterPreposition(Preposition, Pronoun):-
    Preposition = a,
    Pronoun = mi.
pronounIsObliqueAfterPreposition(Preposition, Pronoun):-
    Preposition = none,
    Pronoun = yo.



% A rule that holds if declension is consistent within NounPhrase.  
% NounPhrase is a nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adjective_before, Noun, Adjective_after)
verbPhraseIsGrammatical(VerbPhrase):-
    verbPhraseLD(VerbPhrase, Adverb_before, ReflexivePronoun, Verb, Infinitive, NounPhrase),
    nounPhraseIsGrammatical(NounPhrase).



% Relates a Sentence to a Target atom that is considered the most important word given the structure of the sentence.
% This relation also includes a Value positive or negative for the target depending on the verb and whether the adverb no is present.
% The target is the adjective at the start of the noun phrase of the verb phrase (Adjective_before) if the verb is soy and there are no more words after it
targetOfSentence(Sentence, Target, Value):-
    sentenceLD(Sentence, _, VerbPhrase),
    verbPhraseLD(VerbPhrase, Adverb_before, ReflexivePronoun, soy, none, NounPhraseOfVerbPhrase),
    % Structure of nounPhraseLD: nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after)
    nounPhraseLD(NounPhraseOfVerbPhrase, none, none, none, none, Target, none, none, none),
    valueOfVerbAndAdverb(soy, Adverb_before, Value).
targetOfSentence(Sentence, Target, Value):-
    sentenceLD(Sentence, _, VerbPhrase),
    verbPhraseLD(VerbPhrase, Adverb_before, me, considero, none, NounPhraseOfVerbPhrase),
    % Structure of nounPhraseLD: nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after)
    nounPhraseLD(NounPhraseOfVerbPhrase, none, none, none, none, Target, none, none, none),
    valueOfVerbAndAdverb(considero, Adverb_before, Value).

% The target is the verb if there is no noun phrase in the verb phrase nor an infinitive.
targetOfSentence(Sentence, Target, Value):-
    sentenceLD(Sentence, _, VerbPhrase),
    verbPhraseLD(VerbPhrase, Adverb_before, ReflexivePronoun, Target, none, [none, none, none, none, none, none, none, none]),
    valueOfVerbAndAdverb(Target, Adverb_before, Value).

% The target is the infinitive if there is no noun phrase in the verb phrase.
targetOfSentence(Sentence, Target, Value):-
    sentenceLD(Sentence, _, VerbPhrase),
    verbPhraseLD(VerbPhrase, Adverb_before, ReflexivePronoun, Verb, Target, [none, none, none, none, none, none, none, none]),
    valueOfVerbAndAdverb(Verb, Adverb_before, Value).



% The target is usually the noun of the noun phrase of the verb phrase otherwise.
targetOfSentence(Sentence, Target, Value):-
    sentenceLD(Sentence, _, VerbPhrase),
    verbPhraseLD(VerbPhrase, Adverb_before, _, Verb, _, NounPhraseOfVerbPhrase),
    % Structure of nounPhraseLD: nounPhraseLD(NounPhrase, Preposition, Determiner, Pronoun, Adverb_before, Adjective_before, Noun, Adverb_after, Adjective_after)
    nounPhraseLD(NounPhraseOfVerbPhrase, _, _, _, _, _, Target, _, _),
    valueOfVerbAndAdverb(Verb, Adverb_before, Value).



% Relates a verb and an adverb to a Value positive or negative.
% If the verb is positive and the Adverb is not no, the value is positive.
valueOfVerbAndAdverb(Verb, Adverb, Value):-
    verb(Verb, positive),
    dif(Adverb, no),
    Value = positive.
% If the verb is positive and the Adverb is no, the value is negative.
valueOfVerbAndAdverb(Verb, Adverb, Value):-
    verb(Verb, positive),
    Adverb = no,
    Value = negative.
% If the verb is negative and the Adverb is not no, the value is negative.
valueOfVerbAndAdverb(Verb, Adverb, Value):-
    verb(Verb, negative),
    dif(Adverb, no),
    Value = negative.
% If the verb is negative and the Adverb is no, the value is positive.
valueOfVerbAndAdverb(Verb, Adverb, Value):-
    verb(Verb, negative),
    Adverb = no,
    Value = positive.


% Relates a Sentence to a Value that is positive or negative depending on the verb and the presence of the adverb no. 
% targetOfSentence(Sentence, Value):-




% ------------------ Recursive BNF with list differences. ------------------


















% /* Direct traits */

% direct_trait(escuchar).
% direct_trait(empatia).

% /* Compound traits */

% compound_trait([resolver, problemas]).

/* Adjectives mapped to logical traits */

% trait_adjective(empatico, empatia).

% /* ---------------- Grammar with phrases ---------------- */

% /* Noun Phrase */

% noun_phrase([Pronoun]) :-
%     pronoun(Pronoun).

% /* Object noun phrase with determiner */

% object_noun_phrase([Determiner, Trait]) :-
%     determiner(Determiner),
%     determiner_trait(Trait).

% /* Object noun phrase direct */

% object_noun_phrase([Trait]) :-
%     direct_trait(Trait).

% /* Object noun phrase compound */

% object_noun_phrase([Trait]) :-
%     compound_trait(Trait).

% /* Verb Phrase simple positive */

% verb_phrase([Verb, ObjectNP]) :-
%     positive_verb(Verb),
%     object_noun_phrase(ObjectNP).

% /* Verb Phrase simple negative */

% verb_phrase([Verb, ObjectNP]) :-
%     negative_verb(Verb),
%     object_noun_phrase(ObjectNP).

% /* Verb Phrase positive with a + personas */

% verb_phrase([Verb, a, [Determiner, personas]]) :-
%     positive_verb(Verb),
%     determiner(Determiner).

% /* Verb Phrase negative with a + personas */

% verb_phrase([Verb, a, [Determiner, personas]]) :-
%     negative_verb(Verb),
%     determiner(Determiner).

% /* Verb Phrase reflexive positive with adverb */

% verb_phrase([Reflexive, Verb, Adverb, Preposition, ObjectNP]) :-
%     reflexive(Reflexive),
%     positive_verb(Verb),
%     adverb(Adverb),
%     preposition(Preposition),
%     object_noun_phrase(ObjectNP).

% /* Verb Phrase reflexive positive without adverb */

% verb_phrase([Reflexive, Verb, Preposition, ObjectNP]) :-
%     reflexive(Reflexive),
%     positive_verb(Verb),
%     preposition(Preposition),
%     object_noun_phrase(ObjectNP).

% /* Verb Phrase copulative */

% verb_phrase([Verb, [Adjective]]) :-
%     copulative_verb(Verb),
%     trait_adjective(Adjective, _).

% /* Sentence */

% sentence([NP, VP]) :-
%     noun_phrase(NP),
%     verb_phrase(VP).

% /* ---------------- Build natural language into phrases ---------------- */

% /* Simple sentence with determiner */

% build_sentence(
%     [Pronoun, Verb, Determiner, Trait],
%     [[Pronoun], [Verb, [Determiner, Trait]]]
% ).

% /* me gusta / me gustan */

% build_sentence(
%     [me, Verb, Determiner, Trait],
%     [[me], [Verb, [Determiner, Trait]]]
% ).

% /* Sentence with a + personas */

% build_sentence(
%     [Pronoun, Verb, a, Determiner, personas],
%     [[Pronoun], [Verb, a, [Determiner, personas]]]
% ).

% /* Reflexive sentence with adverb */

% build_sentence(
%     [Pronoun, Reflexive, Verb, Adverb, Preposition, Determiner, Trait],
%     [[Pronoun], [Reflexive, Verb, Adverb, Preposition, [Determiner, Trait]]]
% ).

% /* Reflexive sentence without adverb */

% build_sentence(
%     [Pronoun, Reflexive, Verb, Preposition, Determiner, Trait],
%     [[Pronoun], [Reflexive, Verb, Preposition, [Determiner, Trait]]]
% ).

% /* Simple sentence direct trait */

% build_sentence(
%     [Pronoun, Verb, Trait],
%     [[Pronoun], [Verb, [Trait]]]
% ).

% /* Compound trait with pronoun */

% build_sentence(
%     [Pronoun, Verb, Trait1, Trait2],
%     [[Pronoun], [Verb, [[Trait1, Trait2]]]]
% ).

% /* Compound trait without pronoun */

% build_sentence(
%     [Verb, Trait1, Trait2],
%     [[yo], [Verb, [[Trait1, Trait2]]]]
% ).

% /* Copulative sentence */

% build_sentence(
%     [Pronoun, Verb, Adjective],
%     [[Pronoun], [Verb, [Adjective]]]
% ).

/* ---------------- Semantic interpretation ---------------- */

process_sentence(Atoms) :-
    next_question(ExpectedTrait),
    sentence([], Atoms, NounPhrase, VerbPhrase),
    sentenceLD(SentenceLD, NounPhrase, VerbPhrase),
    sentenceIsGrammatical(SentenceLD),

    targetOfSentence(SentenceLD, Target, Value),
    % Compare target found with trait expected.
    % Accepts synonyms and all declensions of both target and trait.
    firstDeclension(ExpectedTrait, ExpectedTraitFirstDeclension),
    isSynonym(Target, TargetSynonym),
    firstDeclension(TargetSynonym, TargetSynonymFirstDeclension),
    TargetSynonymFirstDeclension = ExpectedTraitFirstDeclension,
    assert(answer(Value, ExpectedTrait)).

% /* Positive simple sentence */

% process_sentence([_, [Verb, [_, Trait]]]) :-
%     next_question(ExpectedTrait),
%     Trait = ExpectedTrait,
%     positive_verb(Verb),
%     assert(answer(positive, Trait)).

% /* Negative simple sentence */

% process_sentence([_, [Verb, [_, Trait]]]) :-
%     next_question(ExpectedTrait),
%     Trait = ExpectedTrait,
%     negative_verb(Verb),
%     assert(answer(negative, Trait)).

% /* Positive with a + personas */

% process_sentence([_, [Verb, a, [_, personas]]]) :-
%     next_question(ExpectedTrait),
%     ExpectedTrait = personas,
%     positive_verb(Verb),
%     assert(answer(positive, personas)).

% /* Negative with a + personas */

% process_sentence([_, [Verb, a, [_, personas]]]) :-
%     next_question(ExpectedTrait),
%     ExpectedTrait = personas,
%     negative_verb(Verb),
%     assert(answer(negative, personas)).

% /* Positive direct trait */

% process_sentence([_, [Verb, [Trait]]]) :-
%     next_question(ExpectedTrait),
%     Trait = ExpectedTrait,
%     positive_verb(Verb),
%     assert(answer(positive, Trait)).

% /* Negative direct trait */

% process_sentence([_, [Verb, [Trait]]]) :-
%     next_question(ExpectedTrait),
%     Trait = ExpectedTrait,
%     negative_verb(Verb),
%     assert(answer(negative, Trait)).

% /* Compound positive */

% process_sentence([_, [Verb, [[Trait1, Trait2]]]]) :-
%     next_question(ExpectedTrait),
%     compound_trait([Trait1, Trait2]),
%     ExpectedTrait = resolver_problemas,
%     positive_verb(Verb),
%     assert(answer(positive, resolver_problemas)).

% /* Compound negative */

% process_sentence([_, [Verb, [[Trait1, Trait2]]]]) :-
%     next_question(ExpectedTrait),
%     compound_trait([Trait1, Trait2]),
%     ExpectedTrait = resolver_problemas,
%     negative_verb(Verb),
%     assert(answer(negative, resolver_problemas)).

% /* Reflexive positive with adverb */

% process_sentence([_, [_, Verb, _, _, [_, Trait]]]) :-
%     next_question(ExpectedTrait),
%     Trait = ExpectedTrait,
%     positive_verb(Verb),
%     assert(answer(positive, Trait)).

% /* Reflexive positive without adverb */

% process_sentence([_, [_, Verb, _, [_, Trait]]]) :-
%     next_question(ExpectedTrait),
%     Trait = ExpectedTrait,
%     positive_verb(Verb),
%     assert(answer(positive, Trait)).

% /* Copulative */

% process_sentence([_, [Verb, [Adjective]]]) :-
%     next_question(ExpectedTrait),
%     copulative_verb(Verb),
%     trait_adjective(Adjective, Trait),
%     Trait = ExpectedTrait,
%     assert(answer(positive, Trait)).

/* ---------------- User input to list of atoms from ChatGPT ---------------- */

read_atoms(Atoms) :-
    read_line_to_string(user_input, String),
    split_string(String, " ", "", Words),
    maplist(atom_string, Atoms, Words).

/* ---------------- Main analyzer ---------------- */

analyze(Atoms) :-
    % read_atoms(Atoms),
    process_sentence(Atoms),
    ask_next.

% analyze(Input) :-
%     build_sentence(Input, Sentence),
%     sentence(Sentence),
%     process_sentence(Sentence),
%     ask_next.

analyze(_) :-
    write('Me puedes repetir, no entendi.'), nl,
    read_answer.

% ---------------- Tests ----------------
testTarget(Target, Value):-
    read_atoms(Atoms),
    sentence([], Atoms, NounPhrase, VerbPhrase),
    sentenceLD(SentenceLD, NounPhrase, VerbPhrase),
    sentenceIsGrammatical(SentenceLD),


    targetOfSentence(SentenceLD, Target, Value).

