using System;
using System.Diagnostics;
using System.IO;

class Program
{
    static void Main()
    {
        string baseDir = AppDomain.CurrentDomain.BaseDirectory;
        string scriptPath = Path.Combine(baseDir, "W11-SecurityHardening-v3-ascii33-2026-07-19.ps1");

        ProcessStartInfo psi = new ProcessStartInfo
        {
            FileName = "powershell.exe",
            Arguments = $"-NoProfile -ExecutionPolicy Bypass -File \"{scriptPath}\"",
            UseShellExecute = true,
            Verb = "runas"
        };

        try
        {
            Process p = Process.Start(psi);
            p.WaitForExit();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error launching script: {ex.Message}");
            Console.WriteLine("Press any key to exit.");
            Console.ReadKey();
        }
    }
}
