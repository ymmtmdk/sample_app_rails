require 'spec_helper'
#load '~/misc/github/ruby-pg/lib/pg_ext.bundle'
=begin
module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      def exec_cache(sql, name, binds)
        stmt_key = prepare_statement(sql)
        type_casted_binds = binds.map { |col, val|
          [col, type_cast(val, col)]
        }

        log(sql, name, type_casted_binds, stmt_key) do
          ##
          p args = type_casted_binds.map { |_, val| val}
          #args[1] += "" if args[1]
          ##

          @connection.send_query_prepared(stmt_key, args)
          @connection.block
          @connection.get_last_result
        end
      rescue ActiveRecord::StatementInvalid => e
        pgerror = e.original_exception
        begin
          code = pgerror.result.result_error_field(PGresult::PG_DIAG_SQLSTATE)
        rescue
          raise e
        end
        if FEATURE_NOT_SUPPORTED == code
          @statements.delete sql_key(sql)
          retry
        else
          raise e
        end
      end
    end
  end
end
=end
describe "with valid information" do
  before do
    User.delete_all
    visit signup_path

    fill_in "Name",         with: "Example User"
    fill_in "Email",        with: "user@example.com"
    fill_in "Password",     with: "foobar"
    fill_in "Confirmation", with: "foobar"
  end

  it "should create a user" do
    click_button "Create my account"
  end
end
