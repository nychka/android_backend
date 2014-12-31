class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :show, :update, :destroy]

  def index
    @groups = Group.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @groups, each_serializer: get_serializer_for(:group)}
    end
  end
  def new
    @group = Group.new
  end
  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /steps/1
  # GET /steps/1.json
  def show
    respond_to do |format|
      format.html {render :show, location: @group}
      format.json {render json: @group, serializer: get_serializer_for(:group)}
    end
  end
   # GET /steps/1/edit
  def edit
  end
  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
   
    def set_group
      @group = Group.find(params[:id])
    end
    def group_params
      permitted = available_locales.map {|locale| "title_#{locale.to_s}".to_sym }
      params.require(:group).permit(permitted)
    end
end

