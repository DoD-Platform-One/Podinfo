# Changelog

> Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

---

## [6.7.1-bb.0] - 2025-01-30

### Changed

- Updated chart from upstream 6.6.2 to 6.7.1
- Updated gluon from 0.5.12 to 0.5.14
- Added subchart update configuration to renovate.json
- Replaced requirements.lock with Chart.lock for use with helm v3

## [6.6.2-bb.1] - 2024-12-30

### Changed

- Updated gluon from 0.5.0 to 0.5.12

## [6.6.2-bb.0] - 2024-05-21

### Changed

- Added a renovate to try to keep podinfo up to date
- Updated podinfo from 6.0.0 to 6.6.2
- Added a development maintenance doc
- Updated gluon from 0.2.10 to 0.5.0
- Updated the tests to run with gluon 0.5.0

## [6.0.0-bb.9] - 2023-09-11

### Changed

- Add ability to set customized labels to the pod(s) that are deployed

## [6.0.0-bb.8] - 2023-09-07

### Changed

- Update gluon to pull from registry1

## [6.0.0-bb.7] - 2023-01-12

### Changed

- Update image to pull from ghcr.io

## [6.0.0-bb.6] - 2022-06-28

### Changed

- Updated bb base to 2.0.0
- Updated gluon to 0.2.10

## [6.0.0-bb.5] - 2022-01-31

### Modified

- Modified cypress tests and added gluon library

## [6.0.0-bb.4] - 2022-01-18

### Changed

- Fixed typo in helm release dependencies in bigbang
- Fixed helpers template file to include istio annotations

## [6.0.0-bb.3] - 2021-12-02

### Changed

- Updated Grafana dashboard support to align with Big Bang docs

## [6.0.0-bb.2] - 2021-11-30

### Added

- Added Grafana dashboard support

## [6.0.0-bb.1] - 2021-11-09

### Added

- Added Prometheus integration
