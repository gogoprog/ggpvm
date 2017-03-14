
enum Instruction
{
    Set(register:Int, value:Int);
    Add(register:Int, value:Int);
    PrintValue(register:Int);
    WriteChar(register:Int);
    Call(register:Int);
}