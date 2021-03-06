package org.clinical3PO.common.angular.controller;


import java.io.File;

import org.clinical3PO.common.environment.EnvironmentType;
import org.clinical3PO.services.JobSearchService;
import org.clinical3PO.services.JsonService;
import org.clinical3PO.services.constants.SearchOn;
import org.clinical3PO.services.dao.model.JobSearch;
import org.perf4j.aop.Profiled;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("ang/Visualization/PatientWithUserPrefs")
@Component("PatientViewWithUserPrefsAng")
public class PatientViewWithUserPrefs {
	
	private static final Logger logger = LoggerFactory.getLogger(PatientViewWithUserPrefs.class);

	@Autowired
	JobSearchService jobSearchService;
	
	@Autowired
	JsonService jsonService;
	
	@Autowired
	private EnvironmentType envType;

	

	@Profiled(tag = "Preparing the Patient Search Json")
	@RequestMapping(value = "/json/{id}", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getSearchedPatient(@PathVariable("id") String id, Model model) {

		/*
		 * Steps to be performed
		 * 
		 * 1. Get the jobsearch data from DB. 2. Use the filename, destination
		 * directory (from jobsearchbean) to fetch hadoop job output. 3.
		 * Construct json representation. 4. Send back the json.
		 */

		// 1. Get the jobsearch data from DB.

		JobSearch jobSearch = jobSearchService.getJob(new Integer(id)
				.intValue());

		String outDir = jobSearch.getOutputDirectory();
		String outFile = jobSearch.getOutputFileName();

		String filePath = outDir + File.separator + outFile; 

		String jsonBuffer = null;

		String jsonParameters;
				
		if (jobSearch.getSearchOn().equals(SearchOn.BATCHSEARCHRESTRICTED.getSearchOn())){
			String temp = jobSearchService.getBatchSearchParameters(jobSearch);
			jsonParameters = temp.split("\\|")[0];
		}
		else{
			jsonParameters = jobSearchService.getPatientSearchWithUserPrefsParameters(jobSearch);
		}
		
		if (envType == EnvironmentType.DEVELOPMENT && logger.isDebugEnabled()){
			logger.debug("jsonParameters: "+jsonParameters);
		}
		
		if (envType == EnvironmentType.PRODUCTION){
			logger.info("jsonParameters "+jsonParameters.length());
		}

		jsonBuffer = jsonService.generateMultiObservationDataJSON(filePath,jsonParameters);

		return (jsonBuffer);
	}

	public JobSearchService getJobSearchService() {
		return jobSearchService;
	}

	public void setJobSearchService(JobSearchService jobSearchService) {
		this.jobSearchService = jobSearchService;
	}

}
