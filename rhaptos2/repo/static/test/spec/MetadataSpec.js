// Generated by CoffeeScript 1.3.3
(function() {

  define(['app/models', 'app/views', 'test/routes'], function(Models, Views, MOCK_CONTENT) {
    return describe('Edit Metadata/Roles', function() {
      beforeEach(function() {
        this.model = new Models.Module();
        this.model.set(MOCK_CONTENT);
        this.metadataView = new Views.MetadataEditView({
          model: this.model
        });
        this.rolesView = new Views.RolesEditView({
          model: this.model
        });
        this.metadataModal = new Views.ModalWrapper(this.metadataView, 'Edit Metadata (test)');
        return this.rolesModal = new Views.ModalWrapper(this.rolesView, 'Edit Roles (test)');
      });
      return describe('(Sanity Check) All Views', function() {
        it('should have a .$el', function() {
          expect(this.metadataView.$el).not.toBeFalsy();
          expect(this.rolesView.$el).not.toBeFalsy();
          expect(this.metadataModal.$el).not.toBeFalsy();
          return expect(this.rolesModal.$el).not.toBeFalsy();
        });
        it('should initially be hidden', function() {
          return expect(this.metadataView.$el.is(':visible')).toEqual(false);
        });
        return it('should show without errors', function() {
          expect(this.metadataModal.show.bind(this.metadataModal)).not.toThrow();
          expect(this.metadataModal.hide.bind(this.metadataModal)).not.toThrow();
          expect(this.rolesModal.show.bind(this.rolesModal)).not.toThrow();
          return expect(this.rolesModal.hide.bind(this.rolesModal)).not.toThrow();
        });
      });
    });
  });

}).call(this);