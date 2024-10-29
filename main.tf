resource "aws_cloudwatch_log_metric_filter" "elb_metric_filter" {
  count          = length(var.elb_names)
  log_group_name = var.cw_log_group_name
  name           = "${var.elb_names[count.index]}-metric-filter"
  pattern        = "{ ($.eventSource = elasticloadbalancing.amazonaws.com) && ($.requestParameters.loadBalancerName = \"${var.elb_names[count.index]}\") && ($.eventName = \"${join("\" || $.eventName = \"", var.elb_event_names)}\") }"

  metric_transformation {
    name      = "${var.elb_names[count.index]}-metric-filter"
    namespace = var.cw_metric_filter_namespace
    value     = var.cw_metric_filter_value
  }
}

resource "aws_cloudwatch_metric_alarm" "elb_metric_filter_alarm" {
  count               = length(var.elb_names)
  alarm_name          = "${var.elb_names[count.index]}-metric-filter-alarm"
  comparison_operator = var.cw_metric_filter_alarm_comparison_operator
  evaluation_periods  = var.cw_metric_filter_alarm_evaluation_periods
  metric_name         = "${var.elb_names[count.index]}-metric-filter"
  namespace           = var.cw_metric_filter_namespace
  period              = var.cw_metric_filter_alarm_period
  statistic           = var.cw_metric_filter_alarm_statistic
  threshold           = var.cw_metric_filter_alarm_threshold
  alarm_description   = "Alarm when ELB ${var.elb_names[count.index]} exceeds the specified threshold."
  alarm_actions       = var.cw_metric_filter_alarm_actions
}
