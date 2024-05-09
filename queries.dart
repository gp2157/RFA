class Queries{

Queries(){
 qitemValues = List.generate(13, (index) => '2023');
    qdurationValues = List.generate(13, (index) => 'Yearly');
    qdayDivisionValues = List.generate(13, (index) => 'Jan to Jun');
    qcategoryDivision = List.generate(13,(index) => 'Total');
    qmonth = List.generate(13,(index) => 'Jan');
    qquarter = List.generate(13,(index) => '1st Quarter');
}


  late List<String> qitemValues;
  late List<String> qdurationValues;
  late List<String> qdayDivisionValues;
  late List<String> qcategoryDivision;
  late List<String> qmonth;
  late List<String> qquarter;


  String graph1(String year, String duration, String division, String month, String quarter){


    if(year==qitemValues[0] && duration==qdurationValues[0] && division==qdayDivisionValues[0] && month==qmonth[0] && quarter==qquarter[0]){
      return 'Same';
    }

    qitemValues[0] = year;
    qdurationValues[0] = duration;
    qdayDivisionValues[0] = division;
    qmonth[0] = month;
    qquarter[0] = quarter;


    String q ='';
    if(duration == 'Yearly')
    {
      q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;';
    }

    else if(duration=='Monthly'){
      String m = getMonth(month);
      q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) = \'${m}\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;';
    }

    else if(duration=='Quarterly'){
      List<String> m = getQuarter(quarter);
      q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'${m[0]}\' AND \'${m[1]}\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;';
    }

    else if(duration=='Semi Annually'){
      if(division == 'Jan to Jun'){
        q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'01\' AND \'06\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;';
      }
      else{
        q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'07\' AND \'12\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;';
      }
    }

    else{
      q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'01\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;';
    }

    return q;
  }

  String getMonth(String m){
    if(m=='Jan') return '01';
    if(m=='Feb') return '02';
    if(m=='Mar') return '03';
    if(m=='Apr') return '04';
    if(m=='May') return '05';
    if(m=='Jun') return '06';
    if(m=='Jul') return '07';
    if(m=='Aug') return '08';
    if(m=='Sep') return '09';
    if(m=='Oct') return '10';
    if(m=='Nov') return '11';
    else return '12';
  }

  List<String> getQuarter(String m){
    if(m=='1st Quarter') return ['01','03'];
    if(m=='2nd Quarter') return ['04','06'];
    if(m=='1rd Quarter') return ['07','09'];
    else return ['10','12'];
  }

  String graph2(String year, String duration, String division, String month, String quarter){
    String q='';
    
    if(year==qitemValues[1] && duration==qdurationValues[1] && division==qdayDivisionValues[1] && month==qmonth[1] && quarter==qquarter[1]){
      return 'Same';
    }

    qitemValues[1] = year;
    qdurationValues[1] = duration;
    qdayDivisionValues[1] = division;
    qmonth[1] = month;
    qquarter[1] = quarter;

    if(duration == 'Yearly')
    {
      q = 'SELECT p.Category, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.Category ORDER BY TotalSales DESC LIMIT 5;';
    }
    else if(duration=='Monthly'){
      String m = getMonth(month);
      q= 'SELECT p.Category, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) = \'${m}\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.Category ORDER BY TotalSales DESC LIMIT 5;';
    }
    else if(duration=='Quarterly'){
      List<String> m = getQuarter(quarter);
      q = 'SELECT p.Category, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'${m[0]}\' AND \'${m[1]}\'  AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.Category ORDER BY TotalSales DESC LIMIT 5;';
    }
    else if(duration=='Semi Annually'){
      if(division == 'Jan to Jun'){
        q = 'SELECT p.Category, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'01\' AND \'06\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.Category ORDER BY TotalSales DESC LIMIT 5;';
      }
      else{
        q = 'SELECT p.Category, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -7, 2) BETWEEN \'07\' AND \'12\' AND substr(t.DateOfPurchase, -4) = \'2023\' GROUP BY p.Category ORDER BY TotalSales DESC LIMIT 5;';
      }
    }
    return q;
  }

  String graph4(String year, String duration, String division, String month, String quarter){
    String q='';
    
    if(year==qitemValues[3] && duration==qdurationValues[3] && division==qdayDivisionValues[3] && month==qmonth[3] && quarter==qquarter[3]){
      return 'Same';
    }

    qitemValues[3] = year;
    qdurationValues[3] = duration;
    qdayDivisionValues[3] = division;
    qmonth[3] = month;
    qquarter[3] = quarter;

    if(duration == 'Yearly')
    {
      q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalExpenses FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE t.NatureOfPurchase = \'Sell\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.productNames ORDER BY TotalExpenses DESC LIMIT 5;';
    }
    else if(duration=='Monthly'){
      String m = getMonth(month);
      q= 'SELECT p.productNames, SUM(t.amountPaid) AS TotalExpenses FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE t.NatureOfPurchase = \'Sell\' AND substr(t.DateOfPurchase, -7, 2) = \'${m}\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.productNames ORDER BY TotalExpenses DESC LIMIT 5;';
    }
    else if(duration=='Quarterly'){
      List<String> m = getQuarter(quarter); 
      q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalExpenses FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE t.NatureOfPurchase = \'Sell\' AND substr(t.DateOfPurchase, -7, 2) BETWEEN \'${m[0]}\' AND \'${m[1]}\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.productNames ORDER BY TotalExpenses DESC LIMIT 5;';
    }
    else if(duration=='Semi Annually'){
      if(division == 'Jan to Jun'){
        q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalExpenses FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE t.NatureOfPurchase = \'Sell\' AND substr(t.DateOfPurchase, -7, 2) BETWEEN \'01\' AND \'06\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.productNames ORDER BY TotalExpenses DESC LIMIT 5;';
      }
      else{
        q = 'SELECT p.productNames, SUM(t.amountPaid) AS TotalExpenses FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE t.NatureOfPurchase = \'Sell\' AND substr(t.DateOfPurchase, -7, 2) BETWEEN \'07\' AND \'12\' AND substr(t.DateOfPurchase, -4) = \'${year}\' GROUP BY p.productNames ORDER BY TotalExpenses DESC LIMIT 5;';
      }
    }
    return q;
  }

  String graph5(String year, String duration, String division, String month, String quarter){
    String q='';
    
    if(year==qitemValues[4] && duration==qdurationValues[4] && division==qdayDivisionValues[4] && month==qmonth[4] && quarter==qquarter[4]){
      return 'Same';
    }

    qitemValues[4] = year;
    qdurationValues[4] = duration;
    qdayDivisionValues[4] = division;
    qmonth[4] = month;
    qquarter[4] = quarter;

    if(duration == 'Yearly')
    {
      q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Buy\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
    }
    else if(duration=='Monthly'){
      String m = getMonth(month);
      q= 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Buy\' AND substr(DateOfPurchase, -7, 2) = \'${m}\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
    }
    else if(duration=='Quarterly'){
      List<String> m = getQuarter(quarter); 
      q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Buy\' AND substr(DateOfPurchase, -7, 2) BETWEEN  \'${m[0]}\' AND \'${m[1]}\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
    }
    else if(duration=='Semi Annually'){
      if(division == 'Jan to Jun'){
        q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Buy\' AND substr(DateOfPurchase, -7, 2) BETWEEN  \'01\' AND \'06\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
      }
      else{
        q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Buy\' AND substr(DateOfPurchase, -7, 2) BETWEEN  \'07\' AND \'12\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
      }
    }
    return q;
  }

  String graph6(String year, String duration, String division, String month, String quarter){
    String q='';
    
    if(year==qitemValues[5] && duration==qdurationValues[5] && division==qdayDivisionValues[5] && month==qmonth[5] && quarter==qquarter[5]){
      return 'Same';
    }

    qitemValues[5] = year;
    qdurationValues[5] = duration;
    qdayDivisionValues[5] = division;
    qmonth[5] = month;
    qquarter[5] = quarter;

    if(duration == 'Yearly')
    {
      q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Sell\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
    }
    else if(duration=='Monthly'){
      String m = getMonth(month);
      q= 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Sell\' AND substr(DateOfPurchase, -7, 2) = \'${m}\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
    }
    else if(duration=='Quarterly'){
      List<String> m = getQuarter(quarter); 
      q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Sell\' AND substr(DateOfPurchase, -7, 2) BETWEEN  \'${m[0]}\' AND \'${m[1]}\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
    }
    else if(duration=='Semi Annually'){
      if(division == 'Jan to Jun'){
        q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Sell\' AND substr(DateOfPurchase, -7, 2) BETWEEN  \'01\' AND \'06\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
      }
      else{
        q = 'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Sell\' AND substr(DateOfPurchase, -7, 2) BETWEEN  \'07\' AND \'12\' AND substr(DateOfPurchase, -4) = \'${year}\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;';
      }
    }
    return q;
  }

  String graph8(String year, String type, String p,String c){
    String q='';
    if(type=='Total'){
      q = 'SELECT SUM(amountPaid) AS TotalSales FROM transactions WHERE substr(DateOfPurchase, -4) = \'${year}\' AND NatureOfPurchase = \'Buy\' GROUP BY substr(DateOfPurchase, 4, 2);';
    }
    else if(type=='C wise'){
    q = 'SELECT SUM(amountPaid) AS TotalSales FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' AND t.NatureOfPurchase = \'Buy\' AND p.Category = \'${c}\' GROUP BY substr(t.DateOfPurchase, 4, 2);';
    }
    else if(type=='P wise'){
       q = 'SELECT SUM(amountPaid) AS TotalSales FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' AND t.NatureOfPurchase = \'Buy\' AND p.productNames = \'${p}\' GROUP BY substr(t.DateOfPurchase, 4, 2);';
    }
    return q;
  }
  String graph9(String year, String type, String p,String c){
    String q='';
    if(type=='Total'){
      q = 'SELECT SUM(amountPaid) AS TotalSales FROM transactions WHERE substr(DateOfPurchase, -4) = \'${year}\' AND NatureOfPurchase = \'Sell\' GROUP BY substr(DateOfPurchase, 4, 2);';
    }
    else if(type=='C wise'){
    q = 'SELECT SUM(amountPaid) AS TotalSales FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' AND t.NatureOfPurchase = \'Sell\' AND p.Category = \'${c}\' GROUP BY substr(t.DateOfPurchase, 4, 2);';
    }
    else if(type=='P wise'){
       q = 'SELECT SUM(amountPaid) AS TotalSales FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' AND t.NatureOfPurchase = \'Sell\' AND p.productNames = \'${p}\' GROUP BY substr(t.DateOfPurchase, 4, 2);';
    }
    return q;
  }

  String graph10(String year, String type, String p,String c){
    String q='';
    if(type=='Total'){
      q = 'SELECT (SELECT IFNULL(SUM(amountPaid), 0) FROM transactions WHERE substr(DateOfPurchase, -4) = \'${year}\' AND NatureOfPurchase = \'Sell\' GROUP BY substr(DateOfPurchase, 4, 2)) - (SELECT IFNULL(SUM(amountPaid), 0) FROM transactions WHERE substr(DateOfPurchase, -4) = \'${year}\' AND NatureOfPurchase = \'Buy\' GROUP BY substr(DateOfPurchase, 4, 2)) AS Profit;';
    }
    else if(type=='C wise'){
    q = 'SELECT substr(t.DateOfPurchase, 4, 2) AS Month, ( (SELECT IFNULL(SUM(amountPaid), 0) FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'2023\' AND t.NatureOfPurchase = \'Sell\' AND p.Category = \'${c}\') - (SELECT IFNULL(SUM(amountPaid), 0) FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' AND t.NatureOfPurchase = \'Buy\' AND p.Category = \'${c}\') ) AS Profit FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'2023\' GROUP BY substr(t.DateOfPurchase, 4, 2);';
    }
    else if(type=='P wise'){
       q = 'SELECT substr(t.DateOfPurchase, 4, 2) AS Month, ( (SELECT IFNULL(SUM(amountPaid), 0) FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'2023\' AND t.NatureOfPurchase = \'Sell\' AND p.productNames = \'${c}\') - (SELECT IFNULL(SUM(amountPaid), 0) FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'${year}\' AND t.NatureOfPurchase = \'Buy\' AND p.productNames = \'${c}\') ) AS Profit FROM transactions AS t JOIN pokemon AS p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'2023\' GROUP BY substr(t.DateOfPurchase, 4, 2);';

    }
    return q;
  }

}