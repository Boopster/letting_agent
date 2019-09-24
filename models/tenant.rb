require_relative('../db/sql_runner')

class Tenant

  attr_reader(:first_name, :last_name, :contact_no, :email, :id)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @contact_no = options['contact_no']
    @email = options['email']
    @tenant_status = options['tenant_status']
  end

  def save()
    sql = "INSERT INTO tenants
    (
      first_name,
      last_name,
      contact_no,
      email
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@first_name,@last_name,@contact_no,@email]
    results = SqlRunner.run(sql,values)
    @id = results.first()['id'].to_i()
  end

  # UPDATE TENANT DETAILS

  def update()
    sql = "UPDATE tenants
    SET
    (
      first_name,
      last_name,
      contact_no,
      email
    )
    =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@first_name,@last_name,@contact_no,@email,@id]
    SqlRunner.run(sql,values)
  end

  # DELETE TENANT

  def delete()
    sql = "DELETE FROM tenants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  # SHOW ALL TENANTS

  def self.all()
    sql = "SELECT * FROM tenants"
    results = SqlRunner.run(sql)
    return results.map { |hash| Tenant.new(hash) }
  end

  # SHOW

  def self.find(id)
    sql = "SELECT * FROM tenants WHERE id = $1"
    values = [id]
    tenant = SqlRunner.run(sql,values)
    return Tenant.new(tenant.first)
  end

end
