<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.error {
	background-color: #ffffff;
	border: 0 solid #fa5858;
	color: #df0101;
	padding: 1px;
}
</style>

<form:form modelAttribute="mlflexForm" method="POST" enctype="multipart/form-data">
	<table class="gridtable">

		<tr>
		<td>Classification Algorithm</td>
			<td>
				<form:select path="classificationAlgorithm" id="classificationAlgorithm">
				  <option value="weka_one_r">One Rule - Weka</option>
				  <option value="weka_svm_linear">Linear SVM - Weka</option>
				  <option value="weka_svm_poly">Polynomial SVM - Weka</option>
				  <option value="weka_svm_rbf">SVM using RBF kernel - Weka</option>
				  <option selected value="weka_naive_bayes">Naive Bayes - Weka</option>
				  <option value="weka_conjunctive_rule">Conjuctive Rule - Weka</option>
				  <option value="weka_decision_tree">Decision Tree - Weka</option>
				  <option value="weka_knn">k Nearest Neighbours - Weka</option>
				  <option value="weka_bagging">Bagging - Weka</option>
				  <option value="c50">Decision Trees learner - Quinlan's C.0</option>
				  <option value="orange_naive_bayes">Naive Bayes - Orange</option>
				  <option value="orange_decision_tree">Decision Tree - Orange</option>		
				  <option value="orange_svm_linear">Linear SVM - Orange</option>
				  <option value="orange_svm_poly">Polynomial SVM - Orange</option>
				  <option value="orange_svm_rbf">SVM using RBF kernel - Orange</option>
				  <option value="r_svm_rbf">SVM using RBF kernel - R</option>
				  <option value="r_svm_linear">Linear SVM - R</option>
				  <option value="r_svm_poly">Polynomial SVM - R</option>
				  <option value="random">Random</option>		  
				</form:select>
			</td>
		</tr>
		
		<tr>
			<td>Number of Folds of ML-FLEX</td>
			<td>			
				<form:input path="folds" id="folds" value="10" />
				<form:errors path="folds" cssClass="error" />
			</td>		
		</tr>
		
		<tr>
			<td>Number of Iterations</td>
			<td>			
				<form:input path="numberOfIterations" id="numberOfIterations" value="1"/>
				<form:errors path="numberOfIterations" cssClass="error" />
			</td>
		</tr>	
		
		<tr>
			<td>Class Property</td>
			<td>
				<form:input path="classProperty" id="classPropertyInput" />
				<form:errors path="classProperty" cssClass="error" />
			</td>
		</tr>
		
		<tr>
			<td>Class Time</td>
			<td>
				<form:input path="classTime" id="classTimeInput" />
				<form:errors path="classTime" cssClass="error" />
			</td>
		</tr>
		
		<tr>
		<td>Start Date</td>
		<td>
			<form:input path="startDate" id="startDateInput" />
			<form:errors path="startDate" cssClass="error" />
		</td>
		</tr>
		
		<tr>
		<td>End Date</td>
		<td>
			<form:input path="endDate" id="endDateInput" />
			<form:errors path="endDate" cssClass="error" />
		</td>
		</tr>	
		
		<tr>
			<td>Start Time</td>
			<td>
				<form:input path="startTime" id="startTimeInput" />
				<form:errors path="startTime" cssClass="error" />
			</td>
		</tr>
		
		<tr>
			<td>End Time</td>
			<td>
				<form:input path="endTime" id="endTimeInput" />
				<form:errors path="endTime" cssClass="error" />
			</td>
		</tr>		
		
		<tr align="center">
			<td colspan="2"><input type="submit" class="styled-button-4" value="Submit"> 
			&nbsp;<input type="reset" class="styled-button-4" value="Clear"></td>
		</tr>
		
	</table>
</form:form>