
<fieldset>
    <div class="form-group">
        <label>Please Select Client </label>

        <select  name="client_id" class="form-control selectpicker" required="required">
            <option value=" " >Please select Client</option>
            <?php
            require_once './config/config.php';
            echo $sql = "select c.id,c.display_name from m_client c inner join `client motorbike details`  m on c.id=m.client_id inner join client_insurance_details d on d.motorbike_details_id=c.id where c.status_enum='300' and c.office_id='50' and d.print_status=1 ";
            $result = mysqli_query(getDbConnection(), $sql);

            $db = getUipDbInstance();
            //  $db->join("client_insurance_details l", "c.id = l.motorbike_details_id", "LEFT");
            //$db->where("l.product_id", 44);
            // $db->where ("(l.product_id = ? or l.product_id = ?)", Array(44,45));
            $db->where("c.status_enum", 300);
            // $db->where("c.id", "NOrT EXISTS (SELECT motorbike_details_id from client_insurance_details)");
            //$db->where("l.loan_status_id", 300);
            $db->where("c.office_id", 50);
            // $db->orderBy("l.id", "desc");
            //$db->orWhere("l.product_id", 45);
            $select = array('c.id', 'c.display_name', 'c.mobile_no', 'c.account_no');
            $customers = $db->get("m_client c", null, $select);

            foreach ($result as $opt) {
                if ($edit && $opt['id'] == $customer['client_id']) {
                    $sel = "selected";
                } else {
                    $sel = "";
                }
                echo '<option value="' . $opt['id'] . '"' . $sel . '>' . $opt['display_name'] . '</option>';
            }
            ?>
        </select>
    </div>  


    <div class="form-group">
        <label for="commence_date">Commencement Date *</label>
        <input type="text" name="commence_date" data-date-format="dd/mm/yyyy" value="<?php echo $edit ? $customer['commence_date'] : ''; ?>" placeholder="Commence Date" class="form-control" required="required" id="commence_date">
    </div> 
    <div class="form-group">
        <label>Period(Months) </label>

        <input type="text" name="period"  value="<?php echo $edit ? $customer['period'] : ''; ?>" placeholder="Period" class="form-control" required="required" id="period">
    </div> 

    <div class="form-group">
        <label for="due_date">Due Date *</label>
        <input type="text" name="due_date" data-date-format="dd/mm/yyyy" value="<?php echo $edit ? $customer['due_date'] : ''; ?>" placeholder="Due Date" class="form-control" required="required" id="duedate">
    </div> 
    <div class="form-group">
        <label for="policy_number">Policy Number *</label>
        <input type="text" name="policy_number" value="<?php echo $edit ? $customer['policy_number'] : ''; ?>" placeholder="Policy Number" class="form-control" required="required" id="policy_number">
    </div> 


    <div class="form-group text-center">
        <label></label>
        <button type="submit" class="btn btn-warning" >Save <span class="glyphicon glyphicon-send"></span></button>
    </div>            
</fieldset>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(function () {
        $("#commence_date").datepicker(
                );

    });
    $(function () {
        $("#duedate").datepicker();
    });


</script>