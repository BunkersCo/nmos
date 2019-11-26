# NMOS FAQ


* [Who is AMWA?](#who-is-amwa)
* [What is the Networked Media Incubator?](#what-is-the-networked-media-incubator)
* [What are IS\-04, IS\-05, IS\-06, etc?](#what-are-is-04-is-05-is-06-etc)
* [Where can I find the NMOS specifications?](#where-can-i-find-the-nmos-specifications)
* [Where can I find an implementation?](#where-can-i-find-an-implementation)
* [What is a Source, Flow, Grain, Node, Device, Sender, Receiver\.\.\.?](#what-is-a-source-flow-grain-node-device-sender-receiver)
* [How does IS\-04 scale?](#how-does-is-04-scale)
* [How can NMOS be used securely?](#how-can-nmos-be-used-securely)
* [Does NMOS require multicast?](#does-nmos-require-multicast)
* [Does NMOS only support RTP?](#does-nmos-only-support-rtp)
* [Does NMOS only support ST 2110?](#down-nmos-only-support-st-2110)
* [Does NMOS work in the cloud?](#does-nmos-work-in-the-cloud)
* [Does NMOS only deal with only individual elemental Flows?](#does-nmos-only-deal-with-individual-elemental-flows)
* [Does NMOS only deal with uncompressed Flows?](#does-nmos-only-deal-with-only-uncompressed-flows)
* [How does my company / project show its Unique Selling Points?](#how-does-my-company--project-show-its-unique-selling-points)
* [If the “O” in NMOS means “open”, why are Incubator workshops closed?](#if-the-o-in-nmos-means-open-why-are-incubator-workshops-closed)
* [What is "NMOS compliant/certified"?](#what-is-nmos-compliantcertified)
* [Can I be sure that I won't be subject to patent fees/litigation if I implement NMOS?](#can-i-be-sure-that-i-wont-be-subject-to-patent-feeslitigation-if-i-implement-nmos)
* [When will IS\-04 / NMOS be standardised? When is it “done”?](#when-will-is-04--nmos-be-standardised-when-is-it-done)
* [Why does IS\-04 have connection management if there is IS\-05?](#why-does-is-04-have-connection-management-if-there-is-is-05)
* [Why does IS\-05 use SDP? And why not <em>just</em> use SDP?](#why-does-is-05-use-sdp-and-why-not-just-use-sdp)
* [Why doesn't IS\-xx do yyy?](#why-doesnt-is-xx-do-yyy)
* [What is the relationship between connection management and network control?](#what-is-the-relationship-between-connection-management-and-network-control)
* [Can I use IS\-xx without having to use IS\-yy?](#can-i-use-is-xx-without-having-to-use-is-yy)
* [How do NMOS specifications fit into the wider community activity on interoperability?](#how-do-nmos-specifications-fit-into-the-wider-community-activity-on-interoperability)



## Who is AMWA?

[AMWA] is the Advanced Media Workflow Association. Originally it was known for developing application specifications for using [MXF] (for example the [AS-11] family is used for delivery of finished media assets to a broadcaster or publisher).

In recent years AMWA has widened its attention to cover the application and control layers for networked media.  Much of this is happening in the Networked Media Incubator project, and this complements other industry activity looking at wire formats and codecs.  

## What is the Networked Media Incubator?

AMWA set up the Networked Media Incubator (also called just "Incubator" here) in September 2015 "to establish open specifications for end-to-end identity, media transport, timing, discovery and registration, connection management and control."

## What are IS-04, IS-05, IS-06, etc?

These are identifiers assigned by AMWA for Interface Specifications they create, including the NMOS specs so far.  

Specs get an IS number once they reach Specification status.  At the time of writing IS-04 is assigned to discovery and registration, IS-05 for connection management and IS-06 for network control.

It is possible that future NMOS specs may not start with "IS".  For example "AS" is used for Application Specifications and "MS" for Data Model Specifications.  Also "BCP" is used for Best Current Practice.

For more detail on AMWA's specification process see [BCP-001].

## Where can I find the NMOS specifications?

Go to the main [NMOS Documentation] page and follow the links to the required specifications.

## Where can I find an implementation?

[This page][NMOS-Solutions] lists many products supporting IS-04 and IS-05 and several open source software implementations. See also the [JT-NM Tested] TR-1001 Catalogue.

## What is a Source, Flow, Grain, Node, Device, Sender, Receiver...?

NMOS uses these common terms (capitalised) in specific ways that may not always correspond to your expectation.  They are defined in the specifications, explained in the [Technical Overview] and summarised in the [Glossary].

## How does IS-04 scale?

IS-04 covers the APIs used for discovery and registration, and how to find the API Endpoints, but does not define an implementation of a registry. This allows implementers and integrators to choose an approach to scalability that is appropriate to topology of the infrastructure and how it is used. Some details on the sorts of considerations which should go into scaling to very large systems is included in the End User Guides on the [wiki][NMOS Wiki], and [this presentation][Scalability] outlines results from a Networked Media Incubator study testing the performance of IS-04 and IS-05 at scale.

## How can NMOS be used securely?

NMOS APIs have supported use of HTTPS and WSS (secure WebSockets) since IS-04 v1.1. So far these haven't been used at Incubator workshops, but this is something we expect to happen in the reasonably near future.

AMWA is developing the [BCP-003] set of Best Common Practices for API Security, including encryption and authorization recommendations.

## Does NMOS require multicast?

**No.** This is an FPM (Frequently Propagated Misunderstanding).

IS-04 specifies how NMOS API Endpoints can be found using DNS-SD. This can use either unicast or multicast DNS.
The JT-NM's [TR-1001-1] recommendations for using SMPTE ST 2110 in engineered networks specifies use of unicast DNS-SD.

Furthermore IS-04's use of DNS-SD is quite minimal – used to "bootstrap" operations.  The main part of IS-04 is based on HTTP and WebSockets, and is _independent of how the Endpoints are discovered_.

(BTW, IS-04 peer-to-peer mode also will work with unicast DNS, although this would be an unusual case. A more likely case is that two devices are connected peer-to-peer via a low-cost switch that treat multicast packets as broadcast – this will still work.)

The Flows that are discovered and connected through NMOS can be multicast (this has usually been the case for Incubator workshops) but can be unicast, and the connection management API supports both multicast and unicast models. See also the question below about RTP.

Generally we have been using multicast and IGMP at the Incubator workshops to date, both for DNS-SD and for media streams. That reflects the focus on 2110-type use cases. Where we need to address different cases, future workshops could take a different approach. See also the question about "the cloud" below.

## Does NMOS only support RTP?

**No.** The transport used for Flows is independent of how the Flows are discovered and how connections are made. Incubator workshops have mostly used RTP, which corresponds to the industry's current attention on ST 2022-6 and ST 2110, but NMOS can be used with HTTP and other transport protocols. 

IS-07 uses WebSockets or MQTT to transport its Flows of events.  

Streampunk's [Arachnid] is an example of how Grains may be transported over HTTP(S), using HTTP headers to carry identity, timestamp and other Grain attributes.

## Does NMOS only support ST 2110?

**No.** See above

## Does NMOS work in the cloud?

**Yes.** The [BBC IP Studio] team has been addressing how its live IP technology – which uses NMOS – can be deployed on a range of platforms, including in-house and public cloud.

## Does NMOS only deal with individual elemental Flows?

**No.** Since v1.1, IS-04 has supported multiplexed Flows. In particular, it has been used with ST 2022-6 (SDI over RTP).

Also [BCP-002-01][BCP-002] specifies how to group together "natural" groups, such as video, audio and data coming from a camera, or multiple video Receivers on a multiviewer.

## Does NMOS deal only with uncompressed Flows?

**No.** See the question about RTP above.

## How does my company / project show its Unique Selling Points?

SDI has allowed users to choose between vendors based on the functionality, features and performance of their devices (amongst other factors), and be sure that they will interoperate correctly, rather than have to think about "box X will work with box Y but not box Z".

It's similar with NMOS – but better because users will be able to use software and virtualised devices, not just hardware ones. NMOS addresses "foundational" building blocks such as identity, discovery and connection management that enable interoperability between networked devices.  

But NMOS doesn't (and won't) attempt to "standardise" the functions, features, or performance of the networked devices. It will however provide a framework that manufactures can link to their specific information. For example hierarchical URIs allow allow manufacturer-specific elements to be included in JSON API messages.

## If the “O” in NMOS means “open”, why are Incubator workshops closed?

The Incubator, and its workshops, have been set up to provide an environment to encourage cooperation between members, and allow them to work together, online and at workshops towards interoperability in a low-risk way. This means that they don't have to worry about their fellow participants – who also may be their competitors – reporting negatively about their implementation, as this is forbidden by the [Incubator rules].

In addition, there are costs associated with running AMWA and the Incubator that are met at least in part through membership fees. Companies need to be an Associate or higher member to participate, and a nominal cost Indvidual membership is also available.

Of course the NMOS specifications themselves are made publicly available (Apache 2 licence) as early as is practical, and at latest on elevation to AMWA Specification.

## What is "NMOS compliant/certified"?

You may see "buy NMOS here" logos at shows, and there's a (partial) list of NMOS-capable products on this wiki.
However, at this time there is no formal compliance/certification programme.
This may change in the near future, as part of the industry's wider testing and compliance work.

Automated test suites available to allow vendors to test their systems, and we use these at workshops.

## Can I be sure that I won't be subject to patent fees/litigation if I implement NMOS?

AMWA's [IPR Policy] attempts to minimise such a risk by requiring participants to disclose any knowledge of possibly relevant patents and requiring all AMWA Specifications to have an IPR review.

In addition, NMOS/Incubator is "RAND-Z" so it requires any contributions to be made available on a reasonable and non-discriminatory basis at zero cost.

And the NMOS APIs are built on widely adopted patterns used on the Internet/Web, using open-source components wherever available.

## When will IS-04 / NMOS be standardised? When is it “done”?

The [NMOS Documentation] page gives the current status of the Specifications. 
You will see that many are already published. You will also see that some have multiple versions. 
As the professional networked media industry matures we can expect requirements to keep changing, so although individual versions will be "done", NMOS will not -- and cannot -- stand still. 

This is commonplace with software products, and reflects the changing nature of the industry. 
However maintaining compatibility is important, and to date all changes introduced have been non-breaking.  
We are also careful to ensure that [different versions of IS-04 implementations can work together][Upgrade Path].

The JT-NM's [TR-1001-1] recommendations for using SMPTE ST 2110 in engineered networks specify use of IS-04 version 1.2 _or higher_ and IS-05 version 1.0 _or higher_.

## Why does IS-04 have connection management if there is IS-05?

**History.** IS-04 v1.0 and v1.1 predate IS-05. A basic connection management mechanism was needed at earlier Incubator workshops so that we could connect together senders and receivers. This was included in IS-04 as an expediency, but doesn't really belong there.  Recent workshops use the separate, and more flexible device connection management API.  The IS-04 mechanism has been deprecated in v1.2 and may be removed in later versions.

## Why does IS-05 use SDP? And why not _just_ use SDP?

Despite its ugliness, as of 2017 [SDP] is still regularly used with RTP media streams, and is included in SMPTE's ST 2110-10 for describing streams. So 2110-compliant senders and receivers will be using it anyway, and it makes sense for IS-05 to use it.

However, IS-05 doesn't _require_ the use of SDP. It abstracts it through the Sender's ``/transportfile`` resource, and alternative formats can be used. For a non-RTP transport this will certainly be the case (e.g. DASH manifest).  

And relying on _just_ SDP itself isn't enough. It describes the streams but doesn't provide a means of making connections, so we would be reliant on proprietary mechanisms.

## Why doesn't IS-xx do yyy?

Maybe it's because that's not something the specification should be doing. For instance, connections could use a break-before-make or make-before-break, but that is implementation/infrastructure-dependent; IS-05 is there to tell the implementation to make the connection, and possibly when to do so.

## What is the relationship between connection management and network control?

The NMOS Network Control API (IS-06) is concerned with what happens within the network itself. It deals with lower-level concepts than IS-04 and IS-05, i.e. network endpoints on NICs and switches, and control of the individual "network flows" between these.

The NMOS Connection Management API (IS-05) is concerned with creation of higher-level _logical_ connections between the Senders and Receivers of Devices. Although it's quite possible that an IS-05 connection/disconnection request may cause a controller to invoke IS-06 to "make it happen", this doesn't have to be the case.  

## Can I use IS-xx without having to use IS-yy?

**Yes, but...** It's possible to use the NMOS specifications independently, but they benefit from being used in combination. For example, the Connection Management API (IS-05) allows connections between manually configured IP addresses (perhaps entered into a spreadsheet?), but this becomes unmanageable in large and changing environments, where the benefits of automated discovery using IS-04 become overwhelming.

And [TR-1001-1] requires use of IS-05.

## How do NMOS specifications fit into the wider community activity on interoperability?

The **Joint Task Force on Networked Media** is a an industry group that was set up a few years ago to coordinate work on interoperability.  The NMOS specifications are part of the JT-NM industry roadmap and IS-04 and IS-05 are mandated in the [TR-1001-1] recommendations. 

The [EBU][EBU-R-152] and [WBU][WBU-Pyramid] support the adoption of IS-04 and IS-05. 



[AMWA]: http://amwa.tv "Advanced Media Workflow Association"

[AMWA Labs]: https://amwa.tv/downloads/brochures/AMWA_Labs_Apr_2017.pdf "AMWA Labs update for NAB 2017"

[Arachnid]: https://github.com/Streampunk/arachnid "Streampunk Arachnid"

[AS-11]: http://www.amwa.tv/projects/AS-11.shtml "AMWA AS-11"

[BBC IP Studio]: http://www.bbc.co.uk/rd/projects/ip-studio "BBC R&D IP Studio"

[BCP-001]: https://www.amwa.tv/specifications "AMWA BCP-001 AMWA Specification Process"

[BCP-002]: https://amwa-tv.github.io/nmos-grouping "AMWA BCP-002 Recommendations for Grouping NMOS Resources"

[BCP-003]: https://amwa-tv.github.io/nmos-api-security "AMWA BCP-003 Security recommendations for NMOS APIs"

[EBU-R-152]: https://tech.ebu.ch/publications/r152 "EBU R 152: Strategy for the Adoption of an NMOS Open Discovery & Connection Protocol"

[End User Guides]: https://github.com/AMWA-TV/nmos/wiki/End-Users "End User Guides"

[Glossary]: https://amwa-tv.github.io/nmos/branches/master/Glossary.html "Glossary"

[NMOS-Solutions]: https://amwa-tv.github.io/nmos/branches/master/NMOS-Solutions.html "NMOS Solutions"

[Incubator rules]: https://www.amwa.tv/bylaws-policy-documents-and-license "AMWA Networked Media Incubator rules"

[IPR Policy]: https://www.amwa.tv/bylaws-policy-documents-and-license "AMWA IPR Policy"

[JT-NM]: http://jt-nm.org "Joint Task Force on Networked Media (JT-NM)"

[JT-NM Tested]: http://jt-nm.org/jt-nm_tested/ "JT-NM Tested"

[MXF]: http://tech.ebu.ch/docs/techreview/trev_2010-Q3_MXF-2.pdf "MXF - a technical review"

[Networked Media Incubator]: http://nmos.tv/about_NMI.html "Networked Media Incubator"

[NMOS Documentation]: https://amwa-tv.github.io/nmos "NMOS Documentation"

[In-stream Signalling Specification]: https://github.com/AMWA-TV/nmos-in-stream-id-timing "AMWA WIP Specification: In-stream Signalling of Identity and Timing information for RTP streams"

[Scalability]: http://www.ipshowcase.org/wp-content/uploads/2019/05/1030-Robert-Porter-Scalability-and-Performance-of-IS-04-and-IS-05-and-How-TR-1001-1-Helps.pdf "Scalability"

[SDP]: https://tools.ietf.org/html/rfc4566 "SDP: Session Description Protocol"

[Technical Overview]: https://amwa-tv.github.io/nmos/branches/master/NMOS_Technical_Overview.html "NMOS Technical Overview"

[TR-1001-1]: http://www.jt-nm.org/documents/JT-NM_TR-1001-1:2018_v1.0.pdf "JT-NM TR-1001: System Environment and Device Behaviors For SMPTE ST 2110 Media Nodes in Engineered Networks"

[Upgrade Path]: https://amwa-tv.github.io/nmos-discovery-registration/tags/v1.3/docs/6.0._Upgrade_Path.html "Upgrade Path"

[WBU-Pyramid]: https://worldbroadcastingunions.org/wbu-supports-ebus-technology-pyramid-for-media-nodes/ "WBU Endorses EBU Pyramid"

[NMOS Wiki]: https://github.com/AMWA-TV/nmos/wiki "NMOS Wiki"