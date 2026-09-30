"""apply_guide_screenreadings_P2P3 -- Cloud's change list P2-1..P2-3 and
P3-1..P3-8 applied to the guide twins, each old string asserted.

Dated: 2026-09-30 16:39 ET
Editor: Claude Code (CGDELL)
Source: ProjectDocs/GatewayGuard_GuideChanges-Parts2-3-ScreenReadings-2026-09-30-1636.md
Targets: ProjectDocs/GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md
         ProjectDocs/GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md
P2-4 is "no change" in Cloud's list. Cloud's "old" text writes line breaks as
" / "; the strings below are the twins' real text, read 2026-09-30 16:39.
Run from the repository root:  python Tool2/apply_guide_screenreadings_P2P3.py
"""
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
P2 = os.path.join(ROOT, "ProjectDocs", "GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md")
P3 = os.path.join(ROOT, "ProjectDocs", "GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md")

CHANGES = {
    P2: [
        ("P2-1 Setting 8, How To Check",
         "How To Check\nWindows 11 Home\nOpen Settings.\nSearch for Device Encryption.\nWindows 11 Pro\nOpen Control Panel.\nOpen BitLocker Drive Encryption.\nHow To Change It",
         "How To Check\n"
         "**Windows 11 Home:** Open Settings > Privacy & security > **Device encryption**. The switch is labelled **Device encryption**.\n\n"
         "**Windows 11 Pro:** Open Control Panel > **BitLocker Drive Encryption**. It should say **Windows (C:) BitLocker on**. **If it says BitLocker suspended, click Resume protection.**\n"
         "How To Change It"),
        ("P2-2 + P2-3 Setting 9, How To Check; VERIFY marker removed",
         "⚠ VERIFY -- a PIN can be created on a local account; a local account cannot reset a forgotten PIN without the account password.\n\n"
         "How To Check\nOpen Settings.\nSelect Accounts.\nSelect Sign-In Options.\nHow To Change It",
         "How To Check\n"
         "**The quickest check:** press the **Windows key** and **L** together. If the screen says **Enter your PIN**, you are set -- type your PIN to sign back in. If it asks for your password, sign back in, then set up a PIN: Settings > Accounts > Sign-in options.\n\n"
         "Below the box, **Sign-in options** shows a key symbol (your password) and a keypad symbol (your PIN). If you ever forget your PIN, click **Sign-in options**, choose the key symbol, and sign in with your password.\n\n"
         "Settings can say Windows Hello is not available on a computer where the PIN works. **The lock screen is the one to believe.**\n"
         "How To Change It"),
    ],
    P3: [
        ("P3-1 Setting 10, Quick Assist paragraph",
         "To let a family member help you, use Quick Assist, which is built into Windows. Press Ctrl + Windows key + Q, or click Start and type Quick Assist. The helper clicks Help someone and reads you a code. You type that code, click Submit, then click Allow. You can end the session at any time by clicking Leave.",
         "To let a family member help you, use Quick Assist, which is built into Windows. Press **Ctrl + Windows key + Q**, or click Start and type Quick Assist.\n\n"
         "**If a box asks \"Let Quick Assist access your camera?\", click No.**\n\n"
         "The window has two halves. Your helper uses **Help someone** on their computer and reads you a code. On yours, under **Get help**, type that code in the box under **Security code from assistant** and click **Submit**. Then click **Allow**. You can end the session at any time by clicking **Leave**."),
        ("P3-2 Setting 10, Quick Assist VERIFY narrowed",
         "⚠ VERIFY -- Quick Assist keys and button labels (Help someone, Submit, Allow, Leave) read off a live screen; currently from Microsoft's pages.",
         "⚠ VERIFY -- **Allow** and **Leave**, which need a real session with a second device; and that sharing works after answering **No** to the camera box."),
        ("P3-3 Setting 10, How To Check; VERIFY removed",
         "It should say Off. If it says On, turn it off.\n\n"
         "If Settings > System has no Remote Desktop entry, your computer is Windows 11 Home and cannot accept these connections. There is nothing to turn off.\n\n"
         "⚠ VERIFY -- exact on-screen path and label on Pro; what Home shows (page absent, or present and greyed).\n",
         "**Windows 11 Pro:** the page has a switch labelled **Remote Desktop**. It should say **Off**. If it says On, turn it off.\n\n"
         "**Windows 11 Home:** the page has no switch. It says: *\"Your Home edition of Windows 11 doesn't support Remote Desktop.\"* **That means this computer is already protected. There is nothing to do.**\n"),
        ("P3-4 Setting 13, What It Is; VERIFY removed",
         "Continue running background extensions and apps keeps Edge running in the background after you close it.\n\n"
         "⚠ VERIFY -- the running-after-close claim, and the exact current label of Edge's background-apps toggle.\n",
         "**Continue running background extensions and apps when Edge is closed** does what its name says: it keeps parts of Edge running after you close it.\n"),
        ("P3-5 Setting 13, How To Check, last line",
         "Review Startup boost and Continue running background extensions and apps.",
         "Review **Startup boost** and **Continue running background extensions and apps when Edge is closed**."),
        ("P3-6 Setting 13, What To Expect -- added",
         "Many users will not notice a significant difference.\n",
         "Many users will not notice a significant difference.\n\n"
         "After Checkup turns these off, Edge shows a **briefcase icon** beside both switches, and you cannot turn them back on in Edge. That is expected. To put them back, see **Part 4, 4.2, Setting 13**.\n"),
        ("P3-7 Setting 14, What To Expect",
         "The panel still opens if you press Windows key + W, and you can turn Widgets back on at any time.",
         "To confirm Widgets is off, press the **Windows key** and **W** together. Nothing should open. You can turn Widgets back on at any time."),
        ("P3-8 Setting 14, VERIFY narrowed",
         "⚠ VERIFY -- Windows key + W with Widgets off, and Dashboards > Discover, read off a live screen.",
         "⚠ VERIFY -- Dashboards > Discover, read off a live screen with Widgets on."),
    ],
}

report = []
for path, items in CHANGES.items():
    raw = open(path, "rb").read()
    crlf = b"\r\n" in raw
    text = raw.decode("utf-8").replace("\r\n", "\n")
    for label, old, new in items:
        n = text.count(old)
        assert n == 1, "%s: old text found %d times (must be exactly 1)" % (label, n)
        text = text.replace(old, new)
        report.append("APPLIED  " + label)
    if crlf:
        text = text.replace("\n", "\r\n")
    open(path, "wb").write(text.encode("utf-8"))
print("\n".join(report))
print("%d of 10 change groups applied (P2-2 and P2-3 together; P2-4 is no change)" % len(report))
