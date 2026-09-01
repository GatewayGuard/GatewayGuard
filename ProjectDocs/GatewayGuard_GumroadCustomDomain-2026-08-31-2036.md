<!-- Dated: 2026-08-31 20:36 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Gumroad custom domain -- what to add, and what NOT to touch

- **Document Name:** GatewayGuard_GumroadCustomDomain
- **Last Modified:** 2026-08-31 20:36 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill, setting up the Gumroad store
- **Covers:** CPM task **T-GR1** (Bill's item 2b) and part of **T-PAY3** (2d)
- **All DNS facts below were measured on CGDELL, 2026-08-31 20:30 ET**

---

## THE ONE-LINE ANSWER

**Add ONE new record. Delete nothing.**

| Host | Type | Value | TTL |
|---|---|---|---|
| `store` | `CNAME` | `domains.gumroad.com` | Automatic |

Then in Gumroad, set the **profile** custom domain to **`store.gatewayguard.co`**.

---

## WHY NOT TO FOLLOW THE HELP ARTICLE AS WRITTEN

The article gives two main options. **Both would take the website down, and one
could stop your email.** Here is what is actually in your DNS right now.

***measured, 2026-08-31 20:30 ET:***

| Record | Current value | What it does |
|---|---|---|
| `gatewayguard.co` (apex) | **A** -> 185.199.108.153, .109.153, .110.153, .111.153 | **These four are GitHub Pages.** The website lives here |
| `www.gatewayguard.co` | **CNAME** -> `gatewayguard.github.io` | The website again |
| `gatewayguard.co` | **MX** -> mx1 / mx2.privateemail.com | **`support@gatewayguard.co`** |
| `gatewayguard.co` | **TXT** -> `v=spf1 include:spf.privateemail.com ~all` | Stops your mail being marked as spam |
| `gatewayguard.co` | **TXT** -> `MS=ms64921263` | Microsoft 365 domain verification |
| Nameservers | `pdns1` / `pdns2.registrar-servers.com` | **Namecheap** |

**So:**

- **The article's first option** (`www CNAME domains.gumroad.com`, plus a URL
  redirect on the apex) **overwrites both website records.** The site would be
  gone and every address would land on Gumroad.
- **The article's second option** (`@ CNAME domains.gumroad.com`) is worse. A
  CNAME at the apex is **not allowed by the DNS standard to sit alongside other
  records at the same name** -- and your apex is carrying **MX and two TXT
  records**. Namecheap will either refuse it or break mail delivery to
  `support@gatewayguard.co`. That address is printed in the licence and in the
  log footer we tell customers to email.

**The subdomain option is in the same article and it costs nothing.**
***measured:*** `store.gatewayguard.co` currently returns NXDOMAIN -- the name
is free.

---

## THE GODADDY SECTION DOES NOT APPLY TO YOU

The article ends with "Point a GoDaddy domain to Gumroad." **Ignore it.**
***measured:*** your nameservers are `pdns1.registrar-servers.com` and
`pdns2.registrar-servers.com`, which are **Namecheap**. The project record
agrees -- *"gatewayguard.co (Namecheap, PremiumDNS, auto-renew ON)."*

GoDaddy appears in the project only in connection with **gatewayguard.com**,
the `.com` we do not own and are watching. Different domain, different
registrar, unrelated to this.

---

## STEP 1 -- ADD THE RECORD AT NAMECHEAP

1. Sign in at **https://ap.www.namecheap.com**
2. **Domain List** -> find `gatewayguard.co` -> **Manage**
3. Open the **Advanced DNS** tab
4. Click **ADD NEW RECORD**
5. Fill it in exactly:
   - **Type:** `CNAME Record`
   - **Host:** `store`
   - **Value:** `domains.gumroad.com`
   - **TTL:** `Automatic`
6. Click the **green tick** to save the row

**Do not edit or delete any existing row.** In particular leave alone the four
`A` records on `@`, the `www` CNAME, both `TXT` rows, and both `MX` rows.

**What you should see when it worked:** a new row reading
`CNAME Record | store | domains.gumroad.com | Automatic`. Nothing else on the
page changes.

---

## STEP 2 -- WAIT, THEN CHECK IT

DNS changes take time to spread. Namecheap is usually minutes; the article says
allow **24 to 48 hours** before deciding it has failed.

**To check it yourself,** double-click `Tool2\Run-CheckStoreDomain.bat`. It is
read-only, needs no administrator rights, and it prints one of two answers in
plain English: the record is live, or it is not there yet.

---

## STEP 3 -- TELL GUMROAD

1. Go to your Gumroad **Settings** -> **Advanced**
2. In the **Custom domain** box, enter:

```
store.gatewayguard.co
```

3. Click **Verify** on the right
4. If it says it failed, **wait and try again** -- it is almost always
   propagation, not a mistake. Re-run the checker in step 2 first: if the
   checker says the record is live and Gumroad still fails, then something is
   genuinely wrong and it is worth asking Gumroad support
5. Click **Update settings** to save

**Use the PROFILE custom domain, not the product one.** You have two products
-- Checkup and the Guide. A profile domain covers your whole storefront and
both products under it. A product domain would cover only one, and you would
need a second subdomain for the other.

Gumroad issues the HTTPS certificate for the subdomain automatically once the
record verifies. There is nothing to buy and nothing to install.

---

## WHY BOTHER AT ALL -- AND IT IS NOT VANITY

**A custom domain is optional. Gumroad works perfectly on
`gatewayguard.gumroad.com`.** ***measured: that address already resolves.*** So
this is not a launch blocker and nothing waits on it.

**But it is worth doing for this product specifically.** Your customer is a
non-technical senior who has been told, correctly and repeatedly, to be
suspicious when a website sends them somewhere else to type in a card number.
Sending them from `gatewayguard.co` to `gatewayguard.gumroad.com` at the exact
moment they reach for their wallet is that pattern. `store.gatewayguard.co`
keeps the name they already trust in front of them through the checkout.

**Do it now rather than in launch week**, because of the propagation window. It
is a fifteen-minute job whose result may take two days to appear, and that is
the worst kind of task to leave until the end.

---

## SEPARATE FINDING, AND IT IS NOT SMALL

***measured, 2026-08-31 20:35 ET:***

| Address | Result |
|---|---|
| `https://gatewayguard.co` | **HTTP 404** |
| `https://www.gatewayguard.co` | **HTTP 404** |
| `https://gatewayguard.github.io` | **HTTP 404** |

**Nothing is being served.** The DNS is correct and pointing at GitHub Pages;
GitHub Pages has nothing in it to serve.

**The project record says otherwise.** The CPM's status table has carried
*"GitHub Pages | index + 404 live"* since 2026-08-02, and a decision entry from
21-Jul says *"index.html and 404.html live on GitHub Pages."* ***That is no
longer true, and nothing noticed.***

**This does not affect the Gumroad work above** -- the store is independent of
the website. But it is on the critical path for the Guide launch, because the
Guide is sold from a site that currently returns 404 at every address. It
belongs with CPM task **T-WQA** and it needs looking at before 15 September.

**Not yet measured:** whether the cause is Pages being switched off, an empty
publishing branch, or a missing `CNAME` file in the
`gatewayguard/gatewayguard.github.io` repository -- which is a **different
repository** from this one, so the file would not be here. That is the first
place to look.
