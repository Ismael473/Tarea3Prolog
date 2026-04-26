:- dynamic answer/2.

career(ingenieria_computadores).
career(psicologia).
career(medicina).
career(artes_musicales).
career(economia).
career(leyes).
career(filosofia).
career(docente).
career(relaciones_internacionales).
career(administracion).
career(bibliotecologia).

affinity(ingenieria_computadores, matematicas).
affinity(ingenieria_computadores, tecnologia).
affinity(ingenieria_computadores, problemas).

affinity(psicologia, personas).
affinity(psicologia, escuchar).
affinity(psicologia, empatia).

affinity(medicina, biologia).
affinity(medicina, personas).
affinity(medicina, disciplina).

affinity(artes_musicales, oido_musical).
affinity(artes_musicales, creatividad).
affinity(artes_musicales, armonia).

affinity(economia, matematicas).
affinity(economia, dinero).
affinity(economia, estadistica).

affinity(leyes, investigacion).
affinity(leyes, personas).
affinity(leyes, diplomacia).

affinity(filosofia, investigacion).
affinity(filosofia, pensamiento_critico).
affinity(filosofia, etica).

affinity(docente, personas).
affinity(docente, paciencia).
affinity(docente, adaptabilidad).

affinity(relaciones_internacionales, investigacion).
affinity(relaciones_internacionales, diplomacia).
affinity(relaciones_internacionales, etica).

affinity(administracion, orden).
affinity(administracion, personas).
affinity(administracion, estadistica).

affinity(bibliotecologia, lectura).
affinity(bibliotecologia, investigacion).
affinity(bibliotecologia, orden).


antagonism(ingenieria_computadores, personas).
antagonism(psicologia, matematicas).
antagonism(medicina, tecnologia).
antagonism(artes_musicales, estadistica).
antagonism(economia, creatividad).
antagonism(leyes, tecnologia).
antagonism(filosofia, estadistica).
antagonism(docente, armonia).
antagonism(relaciones_internacionales, creatividad).
antagonism(bibliotecologia, diplomacia).

question(matematicas, 'Te gustan las matematicas?').
question(tecnologia, 'Te gusta la tecnologia?').
question(problemas, 'Disfrutas de resolver problemas?').
question(personas, 'Te interesan las personas?').
question(escuchar, 'Te gusta escuchar a los demas?').
question(empatia, 'Te consideras empatico?').
question(biologia, 'Te gusta la biologia?').
question(disciplina, 'Te consideras disciplinado?').
question(oido_musical, 'Te consideras alguien con oido musical?').
question(creatividad, 'Te consideras alguien creativido?'). 
question(armonia, 'Te consideras alguien que percibe la armonia musical?').
question(dinero, 'Te consideras alguien que maneja bien el dinero?').
question(estadistica, 'Te gusta la estadistica ?').
question(investigacion, 'Te gusta la investigacion?').
question(diplomacia, 'Te consideras alguien capaz de estar en entornos donde se requiere de diplomacia?').
question(pensamiento_critico, 'Te consideras alguien con pensamiento critico?').
question(etica, 'Te consideras alguien con una etica fuerte?').
question(paciencia, 'Crees que eres alguien paciente?').
question(adaptabilidad, 'Te resulta fácil adaptarte a diferentes escenarios?').
question(orden, 'Eres ordenado?').
question(lectura, 'Te gusta la lectura?').




