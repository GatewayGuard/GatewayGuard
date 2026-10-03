<!-- Dated: 2026-09-06 16:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Reinstalling Windows on SANDY after it has been encrypted

- **Document Name:** GatewayGuard_SandyReinstall
- **Asked for by Bill, 2026-09-06**, answer 7(d): *"find the instructions for
  doing this on Sandy using the bitlocker key we get when we encrypt. Let me
  know what you find out."*
- **Status:** researched and sourced. **Nothing has been run.**

---

# THE HEADLINE, AND IT IS THE OPPOSITE OF WHAT THE QUESTION ASSUMES

**For a clean wipe-and-reinstall of the Windows drive, you do not need the
BitLocker key at all.**

*Sourced, Microsoft Q&A, repeatedly and consistently:* when you boot from
Windows installation media, choose **Custom install**, and **delete every
partition on the drive**, the encrypted volume is destroyed along with
everything else. **No key is asked for, because there is nothing left to
unlock.** No suspending, no decrypting first, no waiting hours for a drive to
decrypt.

> **So the C: half of the job is simpler than expected.** The key is not the
> route in -- **deleting the partitions is.**

**The key is only needed for one thing: getting data OFF the drive before you
wipe it.** If everything worth keeping is already elsewhere, the key never
comes into it for C:.

---

# BUT SANDY HAS A SECOND DRIVE, AND THAT IS WHERE THE KEY MATTERS

***This is the part worth reading twice.***

**SANDY has a 931.5 GB D: drive.** ***That figure comes from
`GatewayGuard_AVScanCoverageTest-2026-08-21.md`, which records SANDY as having
a 931.5 GB D: and CGDELL as having none.***

**If D: is encrypted during testing, a clean install of C: does NOT touch it.**
You delete the C: partitions, install a fresh Windows, and D: is still sitting
there **fully encrypted** -- and the new Windows has never seen it before.

- The **TPM protector is gone**, because that was tied to the old install.
- **The recovery password is the only way in.**
- **A fresh Windows will not unlock it for you.** It will show a locked drive
  and ask.

> **So the single sentence that matters for SANDY: before you wipe C:, make
> sure you have the recovery key for EVERY encrypted volume, not just the
> Windows one.**

**And there is a cleaner alternative for D:** turn BitLocker **off** on D:
before the reinstall, so it decrypts while the machine still knows how. Then
there is nothing to unlock afterwards. **That takes hours on a 931 GB drive**,
so start it and walk away -- but it removes the failure mode entirely.

---

# THE ORDER FOR SANDY -- AND IT IS NOT NEGOTIABLE

**A reinstall destroys three things other open questions depend on.** This is
the same queue as in the decisions document, with the reinstall's own steps
added.

| | Do this first | Why it cannot come later |
|---|---|---|
| **1** | **Export the Malwarebytes scan reports.** Detection History -> Reports -> the 2026-08-11 scan -> Export. | ***Gone forever at step 5.*** It is the only surviving record of the 18 deleted items' names. Five minutes, read-only. |
| **2** | **Look at screen 12** during the ascii44 field run. | SANDY is the only machine with two drives. The drive-order fix cannot be verified anywhere else. |
| **3** | **Run the ascii44 field checklist** -- Console mode, then GUI mode. | Eight fixes nobody has watched run. |
| **4** | **Copy off anything on D: worth keeping**, and write down the recovery key for **every** encrypted volume. | Step 5 makes both irreversible. |
| **5** | **Reinstall.** | Last. |

---

# THE REINSTALL ITSELF

## Before you start

1. **Have the recovery keys in your hand, on paper.** Not just in the
   Microsoft account -- the machine you would sign in from may be the one you
   are wiping.
2. **Copy off anything on D:.**
3. **Have the Windows 11 installation media on a USB stick.** Made with
   Microsoft's Media Creation Tool from a working PC.
4. **Know the Wi-Fi password.** Setup asks, and the saved copy is on the
   machine being wiped.

## The install

1. Boot from the USB stick.
2. Choose **Custom: Install Windows only (advanced)**. **Not Upgrade.**
3. **Delete every partition shown for the Windows disk** -- there will be
   three or four, including small ones. Delete them all until the disk shows
   as one block of unallocated space.
   - **Only the Windows disk.** If D: appears in this list, leave it alone
     unless you have decided to wipe it too.
4. Select the unallocated space and continue. Windows makes its own partitions.
5. **No BitLocker key will be asked for.** If one is, stop -- it means a
   partition was kept rather than deleted.

## Setup, and the one choice that matters for our own research

**Bill's question 7(c) is about what Windows asks during setup.** This
reinstall is the chance to find out first-hand.

> **Watch for two things and write down exactly what the screens say:**
>
> 1. **Is a Microsoft account required, or is there still a local-account
>    route?**
> 2. **Is encryption mentioned at all** -- offered, explained, or done
>    silently?
>
> **That answers 7(c) by observation**, which beats any documentation search.
> **Photograph the screens.**

## Afterwards

- Run `Tool2\Run-InstallAccountCheck.bat`. It records the install date,
  the registered owner, the account types and what is encrypted. **Doing this
  on a machine whose setup you just watched gives us a known-good reading to
  compare every other machine against.**
- **Do not delete any recovery key yet.** Keep every one until the drive has
  been confirmed wiped and re-encrypted. **They cost nothing to keep and they
  cannot be recreated.**

---

# WHAT I COULD NOT ANSWER FROM HERE

**Whether SANDY's D: will be encrypted at that point.** That depends on what
gets selected during the field run. ***Not measured -- CGDELL has one disk and
I have not read SANDY's current state.*** **`Run-InstallAccountCheck.bat` on
SANDY answers it in about ten seconds**, and it is read-only.

**Sources:**
[Microsoft Q&A -- clean install on a BitLocker-protected drive](https://learn.microsoft.com/en-us/answers/questions/5842792/how-to-do-an-clean-install-on-bitlocker-protected) |
[Microsoft Q&A -- BitLocker and clean Windows 11 install](https://learn.microsoft.com/en-us/answers/questions/4011434/bitlocker-and-clean-windows-11-install) |
[Microsoft Q&A -- reinstalling without the recovery key](https://learn.microsoft.com/en-us/answers/questions/5847116/reinstall-windows-because-i-dont-have-bitlocker-ke)
