@osio.regular
Feature: Import a new Booster into OpenShift.io

  Background:
    Given I am logged in to OpenShift.io
    And I have a space created
    And I have GitHub account linked

  @osio.zabbix-metric.import-github-repo
  Scenario: Import booster from a GitHub repository
    When I input a name of the GitHub repository with a booster
    Then I should see the booster imported within 10 seconds
