<!-- Dated: 2026-08-24 17:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# What the experts actually say about Widgets and data collection

- **Document Name:** GatewayGuard_Research-WidgetsDataCollection
- **Last Modified:** 2026-08-24 17:30 ET
- **Question, Bill 2026-08-24:** *"do a deep search and tell me what the experts
  say about widgets and its data collection"*
- **Status:** Research. **The finding is uncomfortable: our own page overstates
  this, and the strongest honest argument is one we are not making.**

---

## THE HEADLINE, BEFORE THE DETAIL

**There is no expert consensus that Widgets is a data-collection problem. The
criticism is almost entirely about ADVERTISING and DISTRACTION.**

Nobody I could find has published a network analysis of Widgets, named a CVE,
or documented covert collection. What the press and the privacy writers
actually object to is that the MSN feed is where Microsoft sells advertising
inside your operating system.

**And the single most useful fact for us: Microsoft is turning that feed off by
default.** They agree with our recommendation, in public, and that is a far
stronger argument to a cautious senior than a privacy claim we cannot fully
source.

---

## 1. WHAT MICROSOFT ITSELF DOCUMENTS

*Sourced, Microsoft Support, "Stay up to date with Widgets in Windows" --
fetched 2026-08-24. These are the operative sentences and there are only four.*

> **"Windows diagnostic data is collected from the Widgets board and is
> determined by the diagnostic data settings you choose in the Windows Settings
> app."**

**This is the one that matters most, and it cuts against our page.** Widgets'
own data collection is **governed by the Diagnostic data setting** -- which is
Checkup's **setting 12**, and Checkup already sets it to **Required only**.
**So Checkup has already reduced Widgets' data collection, through a different
setting, before anyone touches Widgets at all.**

> **"Since each widget or dashboard is powered by a different app or service,
> individual widgets or dashboards might also collect data... Each widget is an
> extension of its corresponding app or service, and it's controlled by the
> settings for that app or service."**

Per-widget, and governed by that widget's own app. **Not a single Widgets
pipeline.**

> **"Location estimation can come from the Windows Location service if enabled,
> otherwise it may fall back on using the IP address of your internet
> connection."**

**Worth knowing and we do not say it:** turning Location off does not make the
weather widget stop knowing roughly where you are. It falls back to your IP
address. A reader who turns Location off believing it stops that has been
misled -- by Windows, not by us, but we could correct it.

> The Discover dashboard is **"personalized using the preferences of your
> Microsoft account."**

**Personalization is tied to the account** -- see section 2, because this is
where our page's central claim comes apart.

**Data review:** the Microsoft privacy dashboard, `account.microsoft.com/privacy`.

---

## 2. THE MICROSOFT ACCOUNT CHANGED, AND IT CHANGES OUR ARGUMENT

**Widgets no longer requires a Microsoft account.** *Sourced:* the requirement
was dropped after testing that began December 2022; signed-out users get the
weather and the news feed, provided the Windows Web Experience Pack is current.

**But personalization is still tied to the account.** Microsoft's own wording is
that Discover is personalised *using the preferences of your Microsoft
account.*

### SO WHO IS OUR READER, AND WHAT IS ACTUALLY BEING COLLECTED ABOUT THEM?

**A senior on a local account, not signed into the Widgets board, with
Diagnostic data set to Required by Checkup.**

For that person:

- **No Microsoft account is attached to the board**, so the personalisation
  record Microsoft describes has nothing to attach to.
- **Diagnostic data from the board is capped at Required** -- by Checkup, via
  setting 12.
- *Sourced, Microsoft's data-collection summary:* **Required** covers device
  connectivity and configuration, product and service performance, and software
  setup and inventory. **Browsing activity, typing samples and app usage
  patterns are in OPTIONAL, not Required.**

**measured on both test machines: SANDY runs the local account `Panther`;
CGDELL runs the local account `willi`.** Neither is a Microsoft account. **They
are the exact case above.**

### WHICH MEANS OUR PAGE OVERSTATES IT

`widgets.html` currently says the panel *"tracks which stories you read, how
long you spend on them, and what you click on -- to serve you more personalized
content."*

**I cannot source that sentence.** Microsoft says the Discover dashboard becomes
more personalised over time using your Microsoft account's preferences. It does
not describe reading-time measurement, and for a signed-out local account there
is no account to personalise against.

**Cloud reached the same conclusion from documentation alone** and recommended
softening it to what can be sourced. **The research supports Cloud.**

---

## 3. WHAT THE CRITICS ACTUALLY CRITICISE -- AND IT IS NOT PRIVACY

*Sourced, across TechRadar, Windows Central, PCWorld, XDA, Thurrott and
Windows Latest:*

- **The MSN feed is Microsoft's advertising revenue surface inside Windows.**
  That is the objection, stated plainly and repeatedly.
- **Windows Search does the same thing** via Search highlights, pointing at
  MSN and Bing. *Worth noting, because Search is the bigger consumer of the
  same runtime -- see the M-2 measurements.*
- **The complaint is intrusiveness and clutter**, not exfiltration. *"Pushy",
  "distracting", "annoying", "noise"* is the vocabulary.
- One recurring caution worth carrying: **turning ads off does not stop the
  collection that would personalise future ads.** That distinction is real and
  our page conflates the two.

**What NOBODY published, and I looked:**

- **No network or packet analysis of Widgets specifically.** Windows telemetry
  is TLS-encrypted, so packet inspection cannot show contents -- which is why
  the independent evidence does not exist rather than being negative.
- **No CVE, no exploit, no privilege issue.**
- **No documented link** between the Widgets feed's ad inventory and the
  browser-locker scam campaign Malwarebytes found in the Edge news feed. Same
  MSN pipeline, *inferred*; Microsoft has published nothing tying them.

**The honest summary: the experts think Widgets is an advertising channel that
Microsoft put in your operating system. They do not think it is spyware.**

---

## 4. THE FACT THAT SHOULD LEAD OUR PAGE -- MICROSOFT AGREES WITH US

*Sourced, 2026:* Microsoft has said it is **"working to make Widgets feel less
distracting and overwhelming by making the experience quiet by default"**, and
recent builds **hide the MSN feed by default**, prioritising the customisable
widget interface instead.

**Microsoft is turning off the thing we tell people to turn off.**

**This is the strongest sentence available to us and we are not using it.** For
a cautious senior, *"Microsoft themselves are switching this off by default in
newer versions"* carries more weight than any privacy argument, and it costs us
nothing in credibility because it is verifiable.

**Cloud's warning still applies:** do not put Microsoft's roadmap in the
customer copy, because it dates. **The way to have both** is to say what is
true now without a version number -- *"Microsoft has begun turning this feed off
by default"* -- and put the citation in the guide's source note.

---

## 5. WHAT I WOULD NOW SAY ON THE PAGE

**Cut:** the reading-tracking sentence. Not sourceable, and wrong for a
signed-out local account.

**Cut:** any suggestion that turning Widgets off stops data going to Microsoft.
The diagnostic-data half is governed by setting 12, which Checkup already
handles.

**Keep and lead with:** it is an advertising and clickbait surface, one
keystroke from the desktop, aimed at exactly the reader most likely to click a
shocking headline. **That is the argument that survives every check today.**

**Add:** Microsoft is turning the feed off by default.

**Add, because it is useful and nobody says it:** turning Location off does not
stop the weather knowing where you are -- it falls back to your IP address.

**Consider adding:** if a reader IS signed into the board with a Microsoft
account, they can see and clear what has been collected at
`account.microsoft.com/privacy`. That is a concrete, checkable action, and it
is more useful than a warning.

---

## 6. THE UNCOMFORTABLE PART

**Three of the four claims on our Widgets page have now failed a check in one
day:**

| Claim | Status |
|---|---|
| *"Turning it off removes the panel"* | **False** -- Win+W still opens it. Fixed |
| *"keeps a background process running... anything still running is still working"* | **Misleading** -- 27 MB, and Windows Search uses 126 MB. Removed |
| *"tracks which stories you read, how long you spend on them, and what you click on"* | **Not sourceable**, and wrong for a signed-out local account. **Still live** |
| The advertising and clickbait surface | **Holds.** The only one that does |

**The page was arguing four things and one of them was true.** That is worth
recording plainly, because the same pattern -- reaching for extra reasons when
one good reason exists -- is what produced the Tamper Protection defect and the
periodic-scanning defect. **A page with one true argument is stronger than a
page with four, three of which a technical reader can dismantle.**

---

## 7. WHAT THIS DOES NOT SETTLE

- **Whether the board's ad inventory is the same one that carried the
  tech-support scam campaign.** *inferred, not sourced.* It should be described
  as *"the same kind of content"*, never *"the same adverts"*.
- **What a signed-IN user actually has collected.** Answerable, but only by
  signing in and reading the privacy dashboard -- and neither test machine is
  signed in, which is itself the useful finding.
- **Whether Widgets' diagnostic data is included in Required or only in
  Optional.** Microsoft's data-collection summary **does not mention Widgets,
  news feeds or content personalisation at either level.** So the link between
  "diagnostic data setting" and "what you read in Widgets" is asserted by the
  Widgets page and not detailed anywhere. **Not measurable from here.**
