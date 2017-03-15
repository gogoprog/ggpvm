
class VirtualMachine
{
    private var program:Program;
    private var cursors:Array<Int>;
    private var stack:Array<Func>;
    private var context:Context;

    public var running = false;
    public var debugging = false;

    public function new()
    {
    }

    public function load(program:Program, context:Context)
    {
        this.program = program;
        this.context = context;
        cursors = [0];
        stack = [program.main];

        running = true;

        Sys.stdout().writeString("[ggpvm] program loaded.\n");
    }

    public function advance(stepCount:Int)
    {
        for(i in 0...stepCount)
        {
            var currentFunc = stack[stack.length - 1];
            var currentCursor = cursors[cursors.length - 1];

            if(currentCursor >= currentFunc.instructions.length)
            {
                if(stack.length > 1)
                {
                    stack.pop();
                    cursors.pop();

                    cursors[cursors.length - 1] += 1;

                    continue;
                }
                else
                {
                    Sys.stdout().writeString("[ggpvm] program ended.\n");
                    running = false;
                    break;
                }
            }

            var instruction = currentFunc.instructions[currentCursor];

            play(instruction);

            cursors[cursors.length - 1] += 1;
        }
    }

    public function play(instruction:Instruction)
    {
        switch(instruction)
        {
            case Set(r, v):
            {
                context.registers[r] = v;
            }

            case Out(r):
            {
                context.outRegisterIndex = r;
            }

            case Add(r, r2):
            {
                context.registers[context.outRegisterIndex] = context.registers[r] + context.registers[r2];
            }

            case PrintValue(r):
            {
                Sys.stdout().writeString("" + context.registers[r] + "\n");
            }

            case WriteChar(r):
            {
                Sys.stdout().writeByte(context.registers[r]);
            }

            case Call(r):
            {
                var i = context.registers[r];
                stack.push(program.funcs[i]);
                cursors.push(-1);
            }

            case JumpIf(r1, r2):
            {
                var v = context.registers[r1];
                var pos = context.registers[r2];

                if(v != 0)
                {
                    cursors[cursors.length - 1] = pos - 1;
                }
            }

            case Compare(r1, r2):
            {
                var a = context.registers[r1];
                var b = context.registers[r2];

                context.registers[context.outRegisterIndex] = ((a == b) ? 1 : 0);
            }

            case Noop:
            {
            }
        }
    }
}