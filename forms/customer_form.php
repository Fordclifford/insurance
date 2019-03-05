<fieldset>
    <div class="form-group">
        <label>Client </label>
        
        <select  name="client_id" class="form-control selectpicker" >
            <option value=" " >Please select Client</option>
            <?php
            require_once './config/config.php';
            $db = getUipDbInstance();
            $db->join("m_loan l", "c.id = l.client_id", "INNER");
            //$db->where("l.product_id", 44);
            $db->where ("(l.product_id = ? or l.product_id = ?)", Array(44,45));
            $db->where("c.status_enum", 300);
            $db->where("l.loan_status_id", 300);
            //$db->orWhere("l.product_id", 45);
            $select = array('c.id', 'c.display_name', 'c.mobile_no', 'c.account_no');
            $customers = $db->get("m_client c", null, $select);
            foreach ($customers as $opt) {
                if ($edit && $opt == $customer['id']) {
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
        
        <select  name="period" class="form-control selectpicker" >
            <option value=" " >Please select Period</option>
            <?php
            $opt_arr = array("1", "3", "6","12");
            
            foreach ($opt_arr as $opt) {
                if ($edit && $opt == $customer['period']) {
                    $sel = "selected";
                } else {
                    $sel = "";
                }
                 echo '<option value="'.$opt.'"' . $sel . '>' . $opt . '</option>';
            }
            ?>
        </select>
    </div> 

    <div class="form-group">
        <label for="number_plate">Number Plate *</label>
        <input type="text" name="number_plate" value="<?php echo $edit ? $customer['number_plate'] : ''; ?>" placeholder="Number Plate" class="form-control" required="required" id="number_plate">
    </div> 
    <div class="form-group">
        <label for="policy_number">Policy Number *</label>
        <input type="text" name="policy_number" value="<?php echo $edit ? $customer['policy_number'] : ''; ?>" placeholder="Policy Number" class="form-control" required="required" id="policy_number">
    </div> 

    <div class="form-group">
        <label for="Model">Model *</label>
        <input type="text" name="Model" value="<?php echo $edit ? $customer['Model'] : ''; ?>" placeholder="Model" class="form-control"  id="Model">
    </div> 
    
     <div class="form-group">
        <label for="Engine">Engine *</label>
        <input type="text" name="Engine" value="<?php echo $edit ? $customer['Engine'] : ''; ?>" placeholder="Engine" class="form-control" id="Model">
    </div> 

    <div class="form-group">
        <label for="Others">Address</label>
        <textarea name="Others" placeholder="Others" class="form-control" id="address"><?php echo ($edit) ? $customer['Others'] : ''; ?></textarea>
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
  $( function() {
    $( "#commence_date" ).datepicker(
            );
    
  } );
  $( function() {
    $( "#duedate" ).datepicker();
  } );
 
  
  </script>