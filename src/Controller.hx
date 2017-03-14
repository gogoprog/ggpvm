
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
        program.main.addInstruction(Instruction.Add(0, 4));
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

    public function resetContext()
    {
        context = new Context();
    }

    public function run()
    {
        vm.load(program, context);

        while(vm.running)
        {
            vm.advance(1);
        }
    }
}