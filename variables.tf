variable "elb_names" {
  description = "The list of elastic load balancer names to monitor."
  type        = list(string)
}

variable "elb_event_names" {
  description = "The list of event names to monitor for each elastic load balancer."
  type        = list(string)
  default     = ["DeleteLoadBalancer", "ModifyLoadBalancerAttributes", "DeleteListener", "ModifyListener", "DeleteTargetGroup", "ModifyTargetGroup"]
}

variable "cw_log_group_name" {
  description = "The name of the CloudWatch log group storing CloudTrail logs."
  type        = string
}

variable "cw_metric_filter_namespace" {
  description = "The namespace for the CloudWatch metric filter."
  type        = string
  default     = "ELB/Monitoring"
}

variable "cw_metric_filter_value" {
  description = "The value to publish to the CloudWatch metric."
  type        = string
  default     = "1"
}

variable "cw_metric_filter_alarm_comparison_operator" {
  description = "The comparison operator for the CloudWatch metric filter alarm."
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "cw_metric_filter_alarm_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 1
}

variable "cw_metric_filter_alarm_period" {
  description = "The period in seconds over which the specified statistic is applied."
  type        = number
  default     = 300
}

variable "cw_metric_filter_alarm_statistic" {
  description = "The statistic to apply to the alarm's associated metric."
  type        = string
  default     = "Sum"
}

variable "cw_metric_filter_alarm_threshold" {
  description = "The value against which the specified statistic is compared."
  type        = number
  default     = 1
}

variable "cw_metric_filter_alarm_actions" {
  description = "The list of actions to execute when the alarm transitions into an ALARM state from any other state."
  type        = list(string)
  default     = []
}
