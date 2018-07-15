function I = model2image_high(model, alpha , beta) 

shape  = coef2object( alpha, model.shapeMU, model.shapePC, model.shapeEV );
tex    = coef2object( beta,  model.texMU,   model.texPC,   model.texEV );

% Render it
rp   = defrp;
rp.width=600;
rp.height=600;
display_face(shape, tex, model.tl, rp);

set(gcf,'PaperPositionMode','auto');
cData = print('-RGBImage','-r300','-opengl');
I=cData;
