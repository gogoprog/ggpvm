
class Controller
{
    private var program:Program;
    private var context:Context;
    private var vm:VirtualMachine = new VirtualMachine();

    public function new()
    {
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

            step();
        }
    }

    public function step()
    {
        if(vm.running)
        {
            vm.advance(1);

            haxe.Timer.delay(
                function()
                {
                    step();
                },
                100);
        }
    }
}