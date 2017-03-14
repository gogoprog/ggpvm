
class Main
{
    static public function main()
    {
        var args = Sys.args();
        var controller = new Controller();

        Sys.stdout().writeString("ggpvm - a experimental virtual machine\n");

        if(args.length > 0)
        {
            Sys.stdout().writeString("[ggpvm] loading program " + args[0] + "...\n");
            controller.loadProgram(args[0]);
        }
        else
        {
            Sys.stdout().writeString("[ggpvm] generating random program...\n");
            controller.generateProgram();
        }

        controller.resetContext();

        controller.run();
    }
}