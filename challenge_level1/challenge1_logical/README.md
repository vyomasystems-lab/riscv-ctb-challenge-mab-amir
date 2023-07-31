# Getting below erros once compiled
test.S:15855: Error: illegal operands `and s7,ra,z4'
test.S:25584: Error: illegal operands `andi s5,t1,s0'

# Removed above errors as below
at line 15855, no ABI register named as "z4", do appended as "a4"
and s7,ra,a4

at line 25584, as "andi" is and I-Type instruction which requires an Immidiate value at one of the source register
i.e. appended as
andi s5,t1,1

#Hence compiled and run successfully