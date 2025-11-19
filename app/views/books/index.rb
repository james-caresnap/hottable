module Views
  class Books::Index < ApplicationComponent
    def initialize(records:, result:, search:, pagy:)
      @records = records
      @result = result
      @search = search
      @pagy = pagy
    end

    def view_template
      render Layout.new do
        div class: "bg-violet-700 flex flex-col flex-nowrap overflow-hidden h-full" do
          headline

          div class: "grow bg-violet-800 flex flex-col flex-nowrap overflow-hidden" do
            tabs

            div class: "grow bg-violet-100 flex flex-col overflow-hidden", data: { controller: "checkbox-set", checkbox_set_total_value: @result.size } do
              div class: "shrink flex justify-between items-center flex-wrap bg-white p-2 min-h-16 border-b" do
                render partial("books/form", search: @search)
              end

              div class: "grow flex items-start -mt-px overflow-scroll", role: "region", aria: { labelledby: "booksTableCaption" }, tabindex: "0" do
                render Views::Table.new(@records, result: @result, search: @search, pagy: @pagy)
              end
            end
          end
        end
      end
    end

    private

    def headline
      header class: "shrink text-white px-4 py-2 flex items-center justify-between" do
        a class: "min-w-0", href: root_path do
          h2(class: "text-xl font-bold leading-7 sm:truncate sm:text-2xl sm:tracking-tight") { "Workspace" }
        end
        div class: "mt-4 flex items-center md:mt-0 md:ml-4" do
          render LogoComponent.new
          span { "HotTable" }
        end
      end
    end

    def tabs
      div class: "shrink" do
        render Books::Tabs.new(View.all.order(created_at: :asc))
      end
    end
  end
end
