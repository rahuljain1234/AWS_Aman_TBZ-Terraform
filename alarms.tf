############################################
# ECS SERVICE – HIGH CPU UTILIZATION
############################################
resource "aws_cloudwatch_metric_alarm" "ecs_high_cpu" {
  alarm_name          = "ecs-service-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2                # 2 x 5 mins = 10 mins
  period              = 300
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.backend.name
  }

  alarm_description = "ECS service CPU usage > 80% for 10 minutes"
}

############################################
# ECS SERVICE – HIGH MEMORY UTILIZATION
############################################
resource "aws_cloudwatch_metric_alarm" "ecs_high_memory" {
  alarm_name          = "ecs-service-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1                # 1 x 5 mins = 5 mins
  period              = 300
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  threshold           = 75

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.backend.name
  }

  alarm_description = "ECS service memory usage > 75% for 5 minutes"
}

############################################
# ALB – 5XX TARGET ERRORS
############################################
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = 300
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  statistic           = "Sum"
  threshold           = 5

  dimensions = {
    LoadBalancer = aws_lb.app_alb.arn_suffix
  }

  alarm_description = "ALB target 5xx errors > 5 in 5 minutes"
}

############################################
# ECS TASK RESTART / TASK COUNT DROP
############################################
resource "aws_cloudwatch_metric_alarm" "ecs_task_count_drop" {
  alarm_name          = "ecs-running-tasks-less-than-desired"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  period              = 300
  metric_name         = "ECSServiceAverageRunningTasks"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  threshold           = aws_ecs_service.backend.desired_count

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.backend.name
  }

  alarm_description = "Running ECS tasks less than desired count for 5 minutes"
}
