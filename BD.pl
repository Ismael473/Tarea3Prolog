:- dynamic answer/2.

career(ingenieria_computadores).
career(psicologia).
career(medicina).

affinity(ingenieria_computadores, matematicas).
affinity(ingenieria_computadores, tecnologia).
affinity(ingenieria_computadores, resolver_problemas).

affinity(psicologia, personas).
affinity(psicologia, escuchar).
affinity(psicologia, empatia).

affinity(medicina, biologia).
affinity(medicina, personas).
affinity(medicina, disciplina).

antagonism(ingenieria_computadores, personas).
antagonism(psicologia, matematicas).
antagonism(medicina, tecnologia).

question(matematicas, "Te gustan las matematicas?").
question(tecnologia, "Te gusta la tecnologia?").
question(resolver_problemas, "Disfrutas de resolver problemas?").

question(personas, 'Te interesan las personas?').
question(escuchar, 'Te gusta escuchar a los demas?').
question(empatia, 'Te consideras empatico?').

question(biologia, 'Te gusta la biologia?').
question(disciplina, 'Te consideras disciplinado?').

