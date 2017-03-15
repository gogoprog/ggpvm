
enum Instruction
{
    Set(register:Int, value:Int);
    Out(register:Int);
    Add(register:Int, register2:Int);
    PrintValue(register:Int);
    WriteChar(register:Int);
    Call(register:Int);
    JumpIf(register:Int, register2:Int);
    Compare(register:Int, register2:Int);
    Noop;
}