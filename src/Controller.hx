
class Controller
{
    private var program:Program;
    private var context:Context;
    private var vm:VirtualMachine = new VirtualMachine();

    public function new()
    {
    }

    public function generateProgram()
    {
        program = new Program();
        program.main = new Func();

        program.main.addInstruction(Instruction.Set(0, 8));
        program.main.addInstruction(Instruction.Set(1, 4));
        program.main.addInstruction(Instruction.Add(0, 1));
        program.main.addInstruction(Instruction.PrintValue(0));
        program.main.addInstruction(Instruction.Set(0, 97));
        program.main.addInstruction(Instruction.WriteChar(0));
        program.main.addInstruction(Instruction.Set(0, 10));
        program.main.addInstruction(Instruction.WriteChar(0));

        var func = new Func();

        func.addInstruction(Instruction.Set(0, 97));
        func.addInstruction(Instruction.WriteChar(0));
        func.addInstruction(Instruction.WriteChar(0));
        func.addInstruction(Instruction.Set(0, 10));
        func.addInstruction(Instruction.WriteChar(0));

        program.funcs.push(func);

        program.main.addInstruction(Instruction.Set(0, 0));
        program.main.addInstruction(Instruction.Call(0));
        program.main.addInstruction(Instruction.Set(0, 0));
        program.main.addInstruction(Instruction.Call(0));
        program.main.addInstruction(Instruction.Set(0, 0));
        program.main.addInstruction(Instruction.Call(0));
    }

    public function loadProgram(filename:String)
    {
        var content:String;

        try
        {
            content = sys.io.File.getContent(filename);
        }
        catch(e:Dynamic)
        {
            Sys.stdout().writeString("[ggpvm] cannot load file.\n");
            return;
        }

        program = Compiler.compile(content);
    }

    public function resetContext()
    {
        context = new Context();
    }

    public function run()
    {
        if(program != null)
        {
            vm.load(program, context);

            while(vm.running)
            {
                vm.advance(1);
            }
        }
    }
}