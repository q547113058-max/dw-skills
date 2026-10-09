# Reverse Engineering With REA

Read the REA skill at `C:\Users\54711\.agents\skills\reverse-engineer-anything\SKILL.md` and use the REA tools available in the current session. REA owns its usage, provider, and evidence rules; DW keeps authorization, scope, evidence, and recovery boundaries.

Use REA when a claim depends on an artifact or runtime that is not available as source: native binaries, packaged or Electron/JavaScript apps, browser pages, managed assemblies, firmware, or observed runtime behavior. For a complete source repository, or a site whose documented API already answers the question, use normal repository and HTTP tools instead.

## Web features and web data sources

- Replicating a page's feature: inspect its shipped JavaScript bundle, or read the browser targets when the user already has the page open on a loopback CDP endpoint.
- Recovering an undocumented data source: inspect a retained HAR or proxy capture. This is discovery only - REA omits credentials, cookies, authorization headers, and raw request/response bodies, so building the integration stays ordinary coding under the project's own auth and rate-limit rules.
- Browser observation is passive: it does not click, navigate, or inject into the page. Use interactive browser tooling for that and REA for the evidence behind it. Runtime capture tools execute the declared target and fall under the external-operations gate.

## All targets

- Static JavaScript/Electron, web, and managed analysis needs no analysis engine. Native binary work needs a configured provider: Hopper, Ghidra 12.1.x, or IDA.
- If REA tooling or a required provider is unavailable, fall back to the project's own read-only tooling and state the limitation in the evidence.
- REA results carry evidence and stated limitations. Cross-check them against the artifact and treat them as evidence, not proof.
- Tools that mutate the target, launch processes, capture scenarios, or write files fall under the external-operations gate: confirm target and scope first, and keep read-only network or cloud storage read-only.
