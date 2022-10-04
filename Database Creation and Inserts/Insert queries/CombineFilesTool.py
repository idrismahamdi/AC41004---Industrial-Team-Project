filenames = ['account insert.txt', 'customer insert.txt','exception insert.txt','exception_audit insert.txt','non_compliance insert.txt','non_compliance_audit insert.txt','platform insert.txt','resource insert.txt','resource_type insert.txt','rule insert.txt','user insert.txt','user_role insert.txt']
  
with open("COMBINED_INSERT.txt", 'w') as outfile:
    outfile.truncate(0)
    
    for names in filenames:
  
        
        with open(names) as infile:
  
            
            outfile.write(infile.read())
  
        outfile.write("\n")
