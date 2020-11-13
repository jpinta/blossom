package com.blossomproject.core.scheduler.job;

import java.util.List;
import org.quartz.JobKey;

public interface ScheduledJobService {

  void changeState(boolean activate);

  List<String> getGroups();

  SchedulerInfo getSchedulerInfo();

  List<JobInfo> getAll(String groupName);

  JobInfo getOne(JobKey jobKey);

  void execute(JobKey jobKey);

  void changeJobState(JobKey jobKey, boolean activate);
}
