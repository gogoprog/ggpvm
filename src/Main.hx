
class Main
{
    static public function main()
    {
        Sys.stdout().writeString("ggpvm - a experimental virtual machine\n");

        var controller = new Controller();

        controller.generateProgram();
        controller.resetContext();

        controller.run();
    }
}