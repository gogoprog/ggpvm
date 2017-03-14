class Compiler
{
    static public function compile(input:String):Program
    {
        var program = new Program();
        var funcAliases = new Array<String>();
        var lines = input.split('\n');

        program.main = new Func();
        var func = program.main;

        var args:Array<Int>;

        for(line in lines)
        {
            var parts = line.split(' ');

            while(parts.remove(""))
            {
            }

            var first = parts.shift();

            args = [];

            if(first != "" && first != null)
            {
                if(first == "@main")
                {
                    func = program.main;
                }
                else if(first.charAt(0) == "@")
                {
                    funcAliases.push(first);
                    func = new Func();
                    program.funcs.push(func);
                }
                else
                {
                    for(p in parts)
                    {
                        if(p.charAt(0) == "@")
                        {
                            args.push(funcAliases.indexOf(p));
                        }
                        else
                        {
                            args.push(Std.parseInt(p));
                        }
                    }

                    var inst = Type.createEnum(Instruction, first, args);

                    func.addInstruction(inst);
                }
            }
        }

        return program;
    }
}