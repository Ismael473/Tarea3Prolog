:- consult('Logic.pl').

/* ---------------- Lexicon ---------------- */

pronoun(yo).
pronoun(me).

reflexive(me).

positive_verb(amo).
positive_verb(adoro).
positive_verb(gusta).
positive_verb(gustan).
positive_verb(disfruto).
positive_verb(encanta).
positive_verb(intereso).
positive_verb(interesa).

negative_verb(odio).
negative_verb(detesto).

copulative_verb(soy).

adverb(mucho).

preposition(por).

determiner(la).
determiner(las).

/* Traits that require determiner */

determiner_trait(matematicas).
determiner_trait(matematica).
determiner_trait(tecnologia).
determiner_trait(personas).
determiner_trait(biologia).

/* Direct traits */

direct_trait(escuchar).
direct_trait(empatia).

/* Compound traits */

compound_trait([resolver, problemas]).

/* Adjectives mapped to logical traits */

trait_adjective(empatico, empatia).

/* ---------------- Grammar with phrases ---------------- */

/* Noun Phrase */

noun_phrase([Pronoun]) :-
    pronoun(Pronoun).

/* Object noun phrase with determiner */

object_noun_phrase([Determiner, Trait]) :-
    determiner(Determiner),
    determiner_trait(Trait).

/* Object noun phrase direct */

object_noun_phrase([Trait]) :-
    direct_trait(Trait).

/* Object noun phrase compound */

object_noun_phrase([Trait]) :-
    compound_trait(Trait).

/* Verb Phrase simple positive */

verb_phrase([Verb, ObjectNP]) :-
    positive_verb(Verb),
    object_noun_phrase(ObjectNP).

/* Verb Phrase simple negative */

verb_phrase([Verb, ObjectNP]) :-
    negative_verb(Verb),
    object_noun_phrase(ObjectNP).

/* Verb Phrase positive with a + personas */

verb_phrase([Verb, a, [Determiner, personas]]) :-
    positive_verb(Verb),
    determiner(Determiner).

/* Verb Phrase negative with a + personas */

verb_phrase([Verb, a, [Determiner, personas]]) :-
    negative_verb(Verb),
    determiner(Determiner).

/* Verb Phrase reflexive positive with adverb */

verb_phrase([Reflexive, Verb, Adverb, Preposition, ObjectNP]) :-
    reflexive(Reflexive),
    positive_verb(Verb),
    adverb(Adverb),
    preposition(Preposition),
    object_noun_phrase(ObjectNP).

/* Verb Phrase reflexive positive without adverb */

verb_phrase([Reflexive, Verb, Preposition, ObjectNP]) :-
    reflexive(Reflexive),
    positive_verb(Verb),
    preposition(Preposition),
    object_noun_phrase(ObjectNP).

/* Verb Phrase copulative */

verb_phrase([Verb, [Adjective]]) :-
    copulative_verb(Verb),
    trait_adjective(Adjective, _).

/* Sentence */

sentence([NP, VP]) :-
    noun_phrase(NP),
    verb_phrase(VP).

/* ---------------- Build natural language into phrases ---------------- */

/* Simple sentence with determiner */

build_sentence(
    [Pronoun, Verb, Determiner, Trait],
    [[Pronoun], [Verb, [Determiner, Trait]]]
).

/* me gusta / me gustan */

build_sentence(
    [me, Verb, Determiner, Trait],
    [[me], [Verb, [Determiner, Trait]]]
).

/* Sentence with a + personas */

build_sentence(
    [Pronoun, Verb, a, Determiner, personas],
    [[Pronoun], [Verb, a, [Determiner, personas]]]
).

/* Reflexive sentence with adverb */

build_sentence(
    [Pronoun, Reflexive, Verb, Adverb, Preposition, Determiner, Trait],
    [[Pronoun], [Reflexive, Verb, Adverb, Preposition, [Determiner, Trait]]]
).

/* Reflexive sentence without adverb */

build_sentence(
    [Pronoun, Reflexive, Verb, Preposition, Determiner, Trait],
    [[Pronoun], [Reflexive, Verb, Preposition, [Determiner, Trait]]]
).

/* Simple sentence direct trait */

build_sentence(
    [Pronoun, Verb, Trait],
    [[Pronoun], [Verb, [Trait]]]
).

/* Compound trait with pronoun */

build_sentence(
    [Pronoun, Verb, Trait1, Trait2],
    [[Pronoun], [Verb, [[Trait1, Trait2]]]]
).

/* Compound trait without pronoun */

build_sentence(
    [Verb, Trait1, Trait2],
    [[yo], [Verb, [[Trait1, Trait2]]]]
).

/* Copulative sentence */

build_sentence(
    [Pronoun, Verb, Adjective],
    [[Pronoun], [Verb, [Adjective]]]
).

/* ---------------- Semantic interpretation ---------------- */

/* Positive simple sentence */

process_sentence([_, [Verb, [_, Trait]]]) :-
    next_question(ExpectedTrait),
    Trait = ExpectedTrait,
    positive_verb(Verb),
    assert(answer(positive, Trait)).

/* Negative simple sentence */

process_sentence([_, [Verb, [_, Trait]]]) :-
    next_question(ExpectedTrait),
    Trait = ExpectedTrait,
    negative_verb(Verb),
    assert(answer(negative, Trait)).

/* Positive with a + personas */

process_sentence([_, [Verb, a, [_, personas]]]) :-
    next_question(ExpectedTrait),
    ExpectedTrait = personas,
    positive_verb(Verb),
    assert(answer(positive, personas)).

/* Negative with a + personas */

process_sentence([_, [Verb, a, [_, personas]]]) :-
    next_question(ExpectedTrait),
    ExpectedTrait = personas,
    negative_verb(Verb),
    assert(answer(negative, personas)).

/* Positive direct trait */

process_sentence([_, [Verb, [Trait]]]) :-
    next_question(ExpectedTrait),
    Trait = ExpectedTrait,
    positive_verb(Verb),
    assert(answer(positive, Trait)).

/* Negative direct trait */

process_sentence([_, [Verb, [Trait]]]) :-
    next_question(ExpectedTrait),
    Trait = ExpectedTrait,
    negative_verb(Verb),
    assert(answer(negative, Trait)).

/* Compound positive */

process_sentence([_, [Verb, [[Trait1, Trait2]]]]) :-
    next_question(ExpectedTrait),
    compound_trait([Trait1, Trait2]),
    ExpectedTrait = resolver_problemas,
    positive_verb(Verb),
    assert(answer(positive, resolver_problemas)).

/* Compound negative */

process_sentence([_, [Verb, [[Trait1, Trait2]]]]) :-
    next_question(ExpectedTrait),
    compound_trait([Trait1, Trait2]),
    ExpectedTrait = resolver_problemas,
    negative_verb(Verb),
    assert(answer(negative, resolver_problemas)).

/* Reflexive positive with adverb */

process_sentence([_, [_, Verb, _, _, [_, Trait]]]) :-
    next_question(ExpectedTrait),
    Trait = ExpectedTrait,
    positive_verb(Verb),
    assert(answer(positive, Trait)).

/* Reflexive positive without adverb */

process_sentence([_, [_, Verb, _, [_, Trait]]]) :-
    next_question(ExpectedTrait),
    Trait = ExpectedTrait,
    positive_verb(Verb),
    assert(answer(positive, Trait)).

/* Copulative */

process_sentence([_, [Verb, [Adjective]]]) :-
    next_question(ExpectedTrait),
    copulative_verb(Verb),
    trait_adjective(Adjective, Trait),
    Trait = ExpectedTrait,
    assert(answer(positive, Trait)).

/* ---------------- Main analyzer ---------------- */

analyze(Input) :-
    build_sentence(Input, Sentence),
    sentence(Sentence),
    process_sentence(Sentence),
    ask_next.

analyze(_) :-
    write('Me puedes repetir, no entendi.'), nl,
    read_answer.