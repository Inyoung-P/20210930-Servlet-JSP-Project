package task;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

@SuppressWarnings("serial")
public class JobScheduler extends HttpServlet {
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		try {
			SchedulerFactory factory = new StdSchedulerFactory();
			Scheduler scheduler = factory.getScheduler();
			scheduler.start();
			JobDetail jobDetail = 
					JobBuilder
					.newJob(OrganizeFileJob.class)
					.build();
			CronTrigger cronTrigger = 
					TriggerBuilder
					.newTrigger()
					.withSchedule(CronScheduleBuilder.cronSchedule("0 0 2 * * ?"))
					.build();
			scheduler.scheduleJob(jobDetail, cronTrigger);
		}
		catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
}
