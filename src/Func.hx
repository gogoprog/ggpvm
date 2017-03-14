
class Func
{
    public var instructions = new Array<Instruction>();

    public function new()
    {
    }

    inline public function addInstruction(i:Instruction)
    {
        instructions.push(i);
    }
}