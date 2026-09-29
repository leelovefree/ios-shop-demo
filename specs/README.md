# specs/

Empty by design. Stage 2 (`spec-extractor` agent) creates `specs/<TICKET-ID>/spec.md` (and, if the
ticket is ambiguous, `specs/<TICKET-ID>/open-questions.md`) at runtime, per ticket — these subfolders
are not created ahead of time. See Section 2 of `ios-qa-automation-requirements.md`.
