<p align="center">
  <a href="" title=""><img src="https://raw.githubusercontent.com/terraform-trailwatch-modules/art/refs/heads/main/logo.jpg" height="100" alt=""></a>
</p>

<h1 align="center">Elastic Load Balancer</h1>

<p align="center">
  <a href="https://github.com/terraform-trailwatch-modules/terraform-trailwatch-elb/releases" title="Releases"><img src="https://img.shields.io/badge/Release-1.0.1-1d1d1d?style=for-the-badge" alt=""></a>
  <a href="https://github.com/terraform-trailwatch-modules/terraform-trailwatch-elb/blob/main/LICENSE" title=""><img src="https://img.shields.io/badge/License-MIT-1d1d1d?style=for-the-badge" alt=""></a>
</p>

## About
This Terraform module creates CloudWatch Log Metric Filters and associated Alarms for monitoring Elastic Load Balancers (ELBs) based on specified event names. It helps ensure that critical changes to ELBs are monitored effectively and alerts are sent to a pre-existing SNS topic.

## Features
- Creates CloudWatch Log Metric Filters for specified ELBs.
- Creates CloudWatch Alarms that trigger based on metrics from the filters.
- Flexible configuration for events to monitor and alarm settings.

## Requirements
- Terraform 1.0 or later
- AWS Provider

## Inputs
| Variable                                     | Description                                                                                          | Type          | Default                                                   |
|----------------------------------------------|------------------------------------------------------------------------------------------------------|---------------|-----------------------------------------------------------|
| `elb_names`                                 | The list of Elastic Load Balancer names to monitor.                                                | `list(string)` | n/a                                                       |
| `elb_event_names`                           | The list of event names to monitor for each Elastic Load Balancer.                                 | `list(string)` | `["DeleteLoadBalancer", "ModifyLoadBalancerAttributes", "DeleteListener", "ModifyListener", "DeleteTargetGroup", "ModifyTargetGroup"]` |
| `cw_log_group_name`                         | The name of the CloudWatch log group storing CloudTrail logs.                                      | `string`      | n/a                                                       |
| `cw_metric_filter_namespace`                | The namespace for the CloudWatch metric filter.                                                    | `string`      | `ELB/Monitoring`                                         |
| `cw_metric_filter_value`                    | The value to publish to the CloudWatch metric.                                                     | `string`      | `1`                                                       |
| `cw_metric_filter_alarm_comparison_operator` | The comparison operator for the CloudWatch metric filter alarm.                                     | `string`      | `GreaterThanOrEqualToThreshold`                          |
| `cw_metric_filter_alarm_evaluation_periods` | The number of periods over which data is compared to the specified threshold.                       | `number`      | `1`                                                       |
| `cw_metric_filter_alarm_period`             | The period in seconds over which the specified statistic is applied.                                | `number`      | `300`                                                     |
| `cw_metric_filter_alarm_statistic`          | The statistic to apply to the alarm's associated metric.                                           | `string`      | `Sum`                                                    |
| `cw_metric_filter_alarm_threshold`          | The value against which the specified statistic is compared.                                       | `number`      | `1`                                                       |
| `cw_metric_filter_alarm_actions`            | The list of actions to execute when the alarm transitions into an ALARM state.                      | `list(string)` | `[]`                                                      |

## Simple Example
```hcl
module "terraform_trailwatch_elb" {
  source                         = "terraform-trailwatch-modules/elb/trailwatch"
  elb_names                      = ["acme-stage-elb", "acme-prod-elb"]
  cw_log_group_name              = "the-cloudtrail-log-group"
  cw_metric_filter_alarm_actions = ["arn:aws:sns:region:account-id:sns-topic"]
}
```

## Advanced Example

```hcl
module "terraform_trailwatch_elb" {
  source                                     = "terraform-trailwatch-modules/elb/trailwatch"
  elb_names                                  = ["acme-stage-elb", "acme-prod-elb"]
  elb_event_names                            = ["DeleteLoadBalancer", "ModifyLoadBalancerAttributes"]
  cw_log_group_name                          = "the-cloudtrail-log-group"
  cw_metric_filter_namespace                 = "ELB/Monitoring"
  cw_metric_filter_value                     = "1"
  cw_metric_filter_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cw_metric_filter_alarm_evaluation_periods  = 1
  cw_metric_filter_alarm_period              = 300
  cw_metric_filter_alarm_statistic           = "Sum"
  cw_metric_filter_alarm_threshold           = 1
  cw_metric_filter_alarm_actions             = ["arn:aws:sns:region:account-id:sns-topic"]
}
```

## Changelog
For a detailed list of changes, please refer to the [CHANGELOG.md](CHANGELOG.md).

## License
This module is licensed under the [MIT License](LICENSE).
